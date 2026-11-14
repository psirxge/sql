# PART 1
# 1. Previe library position traks first and last
SELECT MAX(position), MIN(position) 
FROM library_items 
WHERE user_id = 'u_1';
#------------------------------------
# 2. Search users who not create playlist
SELECT users.username
FROM users
LEFT JOIN playlists ON users.id = playlists.owner
WHERE playlists.id IS NULL;
#------------------------------------
# 3. Print tracks in library from users
SELECT title, position 
FROM library_items 
WHERE user_id = 'u_3' 
#------------------------------------
# 4. Users who not receive gifts 
SELECT username 
FROM users 
WHERE id NOT IN (SELECT recipient_user_id FROM gifts);
#------------------------------------
# 5. Search track (print tracks in name whose available "Love"
SELECT title, artist 
FROM library_items 
WHERE title LIKE '%Love%';
#------------------------------------
# PART 2 
#------------------------------------
# 1. Вывести имя, у которых в библиотеке больше 1 трека(и их колво), 
SELECT u.username, COUNT(li.id) AS total_tracks
FROM users u
JOIN library_items li ON u.id = li.user_id
GROUP BY u.id, u.username
HAVING COUNT(li.id) > 1;
#------------------------------------
# 2. те, кто получал подарки но при этом ни разу никому их не отправлял
SELECT username 
FROM users 
WHERE id IN (SELECT recipient_user_id FROM gifts)
  AND id NOT IN (SELECT sender_user_id FROM gifts WHERE sender_user_id IS NOT NULL);
#------------------------------------
# 3. Категоризация пользователей в зависимости от размера их библиотеки 
SELECT 
    u.username,
    (SELECT COUNT(*) FROM library_items li WHERE li.user_id = u.id) AS track_count,
    CASE 
        WHEN (SELECT COUNT(*) FROM library_items li WHERE li.user_id = u.id) > 3 THEN 'Меломан'
        WHEN (SELECT COUNT(*) FROM library_items li WHERE li.user_id = u.id) BETWEEN 1 AND 3 THEN 'Активный'
        ELSE 'Новичок'
    END AS listener_type
FROM users u;
#------------------------------------
