-- {A table named “famous” has two columns called user id and follower id. It represents each user ID has a particular follower ID. These follower IDs are also users of hashtag#Facebook / 
-- hashtag#Meta. Then, find the famous percentage of each user. Famous Percentage = number of followers a user has / total number of users on the platform.}

with famous_user as (
    select * from famous
),

distinct_user as (
    select user_id from famous_user
    union
    select follower_id from famous_user
),

count_user as (
    select a.user_id, count(b.follower_id) as follower_count
    from distinct_user a right join famous_user b on a.user_id = b.user_id
    group by a.user_id
    order by a.user_id
),

famous_percent as (
    select user_id,round((follower_count*100)/(select count(user_id) from distinct_user),2) as famous_pecentage
    from count_user
)

select * from famous_percent

-------------------------------------------------------------------------------------------------------------------------------------

--Simplified code

with distinct_user as (
    select user_id from famous
    union
    select follower_id from famous
),

famous_percent as (
    select user_id,round((count(follower_id)*100)/(select count(user_id) from distinct_user),2) as famous_pecentage
    from famous
    group by user_id
    order by user_id
)

select * from famous_percent