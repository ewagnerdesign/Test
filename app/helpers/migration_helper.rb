module MigrationHelper

  def add_foreign_key(from_table, from_column, to_table)
    constraint_name = "fk_#{from_table}_#{from_column}"

    execute %{alter table #{from_table}
              add constraint #{constraint_name}
              foreign key (#{from_column})
              references #{to_table}(id)}
  end

  def remove_foreign_key(from_table, from_column)
    constraint_name = "fk_#{from_table}_#{from_column}"

    execute %{alter table #{from_table}
              drop foreign key #{constraint_name}}
  end

  def add_table_check(from_table, check_name, check_text) 
    constraint_name = "chk_#{check_name}"

    execute %{alter table #{from_table} 
              add constraint #{constraint_name} 
              check(#{check_text})}
  end

  def remove_table_check(from_table, check_name)
    constraint_name = "chk_#{check_name}"

    execute %{alter table #{from_table} 
              drop check #{constraint_name}}
  end

  def add_column_check(from_table, from_column, opts) 

    text = case 
      when val = opts[:in]
        "IN (" + val.to_a.collect{|e| e.inspect}.join(',') + ")"
      when val = opts[:between]
        "BETWEEN #{val.first.inspect} AND #{val.last.inspect}"
      else
        opts[:text]
    end.gsub('"', "'")

    add_table_check from_table,
                    "#{from_table}_#{from_column}",
                    "#{from_column} #{text}"
  end

  def remove_column_check(from_table, from_column)
    remove_table_check from_table,
                      "#{from_table}_#{from_column}"
                     
  end

end
