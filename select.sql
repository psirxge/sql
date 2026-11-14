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
