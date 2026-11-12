CREATE TABLE users (
    id VARCHAR(255) PRIMARY KEY,
    telegram_id BIGINT UNIQUE,
    username VARCHAR(255),
    photo_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    source_urls JSON
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE auth_sessions (
    session_id VARCHAR(255) PRIMARY KEY,
    status VARCHAR(50),
    user_id VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE gifts (
    id VARCHAR(255) PRIMARY KEY,
    public_slug VARCHAR(255) UNIQUE,
    sender_user_id VARCHAR(255),
    recipient_user_id VARCHAR(255),
    sender_name VARCHAR(255),
    sender_avatar_url TEXT,
    sender_note TEXT,
    pack_title VARCHAR(255),
    tracks_json JSON,
    received_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (recipient_user_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE admins (
    telegram_id BIGINT PRIMARY KEY,
    FOREIGN KEY (telegram_id) REFERENCES users(telegram_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE library_albums (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    user_id VARCHAR(255),
    title VARCHAR(255),
    artist VARCHAR(255),
    cover_url TEXT,
    album_type VARCHAR(50),
    track_count INT,
    tracks_json JSON,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE library_items (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    user_id VARCHAR(255),
    track_id VARCHAR(255),
    source_platform VARCHAR(50),
    title VARCHAR(255),
    artist VARCHAR(255),
    album VARCHAR(255),
    cover_url TEXT,
    track_json JSON,
    position INT,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE media (
    id VARCHAR(255) PRIMARY KEY,
    owner_user_id VARCHAR(255),
    name VARCHAR(255),
    size INT,
    bytes LONGBLOB,
    FOREIGN KEY (owner_user_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE playlists (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    owner VARCHAR(255),
    title VARCHAR(255),
    description TEXT,
    cover_url TEXT,
    tracks_json JSON,
    sort_order INT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    share_id VARCHAR(255),
    FOREIGN KEY (owner) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE track_cache (
    query_key VARCHAR(255) PRIMARY KEY,
    playload_json JSON, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;