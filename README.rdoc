SQL

дана таблица users вида - id, group_id

create temp table users(id bigserial, group_id bigint);
insert into users(group_id) values (1), (1), (1), (2), (1), (3);
В этой таблице, упорядоченой по ID необходимо:
выделить непрерывные группы по group_id с учетом указанного порядка
записей (их 4)


подсчитать количество записей в каждой группе

WITH    q AS
        (
        select group_id, row_number() over (order by id) - row_number() over (partition by group_id order by id) as res from users
        )

SELECT count(*)
FROM   q
GROUP BY
        group_id, res


вычислить минимальный ID записи в группе

WITH    q AS
        (
        select id, group_id, row_number() over (order by id) - row_number() over (partition by group_id order by id) as res from users
        )

SELECT min(id) as min_id
FROM   q
GROUP BY
        res, group_id
        ORDER BY min_id, group_id
