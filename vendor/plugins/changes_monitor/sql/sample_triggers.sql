delimiter $$
drop trigger if exists users_before_insert;
create trigger users_before_insert before insert on users for each row begin
  declare audits_count int default 0;
  select count(*) into audits_count from audits where id = new.lock_version and auditable_id is null;
  if audits_count < 1 then
    call Create_changes_record_not_found();
  end if;
end $$
delimiter ;

delimiter $$
drop trigger if exists users_after_insert;
create trigger users_after_insert after insert on users for each row begin
  update audits set auditable_id = new.id where id = new.lock_version;
end $$
delimiter ;


delimiter $$
drop trigger if exists users_before_update;
create trigger users_before_update before update on users for each row begin
  declare audits_count int default 0;
  select count(*) into audits_count from audits where
         auditable_id = new.id and auditable_type = 'User' and
         auditable_lock_version = new.lock_version;
  if audits_count < 1 or new.lock_version - old.lock_version != 1 then
    call Update_changes_record_not_found();
  end if;
end $$
delimiter ;


delimiter $$
drop trigger if exists users_before_delete;
create trigger users_before_delete before delete on users for each row begin
  declare audits_count int default 0;
  select count(*) into audits_count from audits where
         auditable_id = old.id and auditable_type = 'User' and
         action = 'destroy' and auditable_lock_version is null;
  if audits_count < 1 then
    call Delete_changes_record_not_found();
  end if;
end $$
delimiter ;
