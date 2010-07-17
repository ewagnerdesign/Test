namespace :changes_monitor do

  desc 'Add MySQL triggers for insert/update/delete operations to check changes'
  task :add, :entity, :needs => :environment do |t, args|
    puts "Adding triggers for insert/update/delete operations"
    perform_operation args.entity, :add_triggers
    t.reenable
  end

  desc 'Remove MySQL triggers checking changes'
  task :remove, :entity, :needs => :environment do |t, args|
    puts "Removing triggers for insert/update/delete operations"
    perform_operation args.entity, :remove_triggers
    t.reenable
  end

  def perform_operation(entity, method)
    class_name, table_name = get_class_and_table_names(entity)

    sql = ActiveRecord::Base.connection();
    sql.begin_db_transaction

    send(method, class_name, table_name, sql)

    sql.commit_db_transaction
  end

  def add_triggers(class_name, table_name, sql)
    remove_triggers class_name, table_name, sql
    q1 = <<adder
create trigger #{table_name}_before_insert before insert on #{table_name} for each row begin
  declare changes_history_count int default 0;
  select count(*) into changes_history_count from changes_history where id = new.lock_version and auditable_id is null;
  if changes_history_count < 1 then
    call Create_changes_record_not_found();
  end if;
end
adder
    q2 = <<adder
create trigger #{table_name}_after_insert after insert on #{table_name} for each row begin
  update changes_history set auditable_id = new.id where id = new.lock_version;
end
adder
    q3 =  <<adder
create trigger #{table_name}_before_update before update on #{table_name} for each row begin
  declare changes_history_count int default 0;
  select count(*) into changes_history_count from changes_history where
         auditable_id = new.id and auditable_type = '#{class_name}' and
         auditable_lock_version = new.lock_version;
  if changes_history_count < 1 or new.lock_version - old.lock_version != 1 then
    call Update_changes_record_not_found();
  end if;
end
adder
    q4 = <<adder
create trigger #{table_name}_before_delete before delete on #{table_name} for each row begin
  declare changes_history_count int default 0;
  select count(*) into changes_history_count from changes_history where
         auditable_id = old.id and auditable_type = '#{class_name}' and
         action = 'destroy' and auditable_lock_version is null;
  if changes_history_count < 1 then
    call Delete_changes_record_not_found();
  end if;
end
adder
    [q1, q2, q3, q4].each do |query|
      sql.execute query
    end
  end

  def remove_triggers(class_name, table_name, sql)
    ["drop trigger if exists #{table_name}_before_insert;",
      "drop trigger if exists #{table_name}_after_insert;",
      "drop trigger if exists #{table_name}_before_update;",
     "drop trigger if exists #{table_name}_before_delete;"].each do |query|
      sql.execute query
    end
  end

  def get_class_and_table_names(entity)
    table_name = ActiveSupport::Inflector::tableize(entity)
    class_name = ActiveSupport::Inflector::classify(entity)
    return class_name, table_name
  end
end
