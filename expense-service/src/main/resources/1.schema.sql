drop table if exists expense_db.public.category CASCADE;
drop table if exists expense_db.public.expense CASCADE ;
drop table if exists expense_db.public.users CASCADE ;
create table expense_db.public.category (id bigint not null, description varchar(255), name varchar(255), primary key (id));
create table expense_db.public.expense (id bigint not null, description varchar(255), expense_date timestamp, location varchar(255), category_id bigint, user_id bigint, primary key (id));
create table expense_db.public.users (id bigint not null, email varchar(255), name varchar(255), primary key (id));
alter table expense_db.public.expense add constraint FKmvjm59reb5i075vu38bwcaqj6 foreign key (category_id) references category;
alter table expense_db.public.expense add constraint FKekyts7i8w5cam119wj1itdom2 foreign key (user_id) references users;
