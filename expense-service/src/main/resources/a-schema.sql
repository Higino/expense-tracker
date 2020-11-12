drop table if exists category CASCADE; 
drop table if exists expense CASCADE;
drop table if exists user CASCADE;
create table category (id bigint not null, description varchar(255), name varchar(255), primary key (id));
create table expense (id bigint not null, description varchar(255), expense_date timestamp, location varchar(255), category_id bigint, user_id bigint, primary key (id));
create table user (id bigint not null, email varchar(255), name varchar(255), primary key (id));
alter table expense add constraint FKmvjm59reb5i075vu38bwcaqj6 foreign key (category_id) references category;
alter table expense add constraint FK758h5dgdblrpwoaaycbmn29i0 foreign key (user_id) references user;