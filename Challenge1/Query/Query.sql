use users;
show tables;
SELECT 
    *
FROM
    Events;
SELECT 
    *
FROM
    users;

-- Challenge1- Have to obtain the percebatge of users who never "like" or "commented" 
-- Approach 1 Using Count () and Distinct on JOIN
SELECT 
    ROUND(((COUNT(DISTINCT u.userid) - COUNT(DISTINCT e.userid)) / COUNT(DISTINCT u.userid)) * 100,
            2) AS 'Percentage of Inactive Users'
FROM
    users AS u
        LEFT JOIN
    events AS e ON u.userid = e.userid
        AND (e.action = 'Comment'
        OR e.action = 'like');
        
 -- Approach 2 Using a varaibles ad Subquerie
SELECT 
    @total_users:=COUNT(*)
FROM
    Users;
SELECT 
    @notcommentednorliked_users:=COUNT(*)
FROM
    Users
WHERE
    NOT EXISTS( SELECT 
            1
        FROM
            Events
        WHERE
            Events.userid = Users.userid
                AND (action = 'comment' OR action = 'like'));
SELECT 
    ROUND((@notcommentednorliked_users / @total_users) * 100,
            2) AS 'Percentage of not like ,not comment';
 
        
        