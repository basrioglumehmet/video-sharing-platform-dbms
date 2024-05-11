CREATE TABLE "accounts" (
  "_id" INT PRIMARY KEY,
  "email" VARCHAR(255) NOT NULL,
  "password" VARCHAR(255) NOT NULL,
  "deleted" BOOLEAN DEFAULT false,
  "banned" BOOLEAN DEFAULT false,
  "created_at" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  "modified_at" TIMESTAMP
);

CREATE TABLE "channel" (
  "_id" INT PRIMARY KEY,
  "account_id" INT UNIQUE,
  "role_id" INT,
  "name" VARCHAR,
  "user_tag" VARCHAR(64),
  "avatar" VARCHAR,
  "description" VARCHAR,
  "created_at" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  "modified_at" TIMESTAMP
);

CREATE TABLE "channel_announcements" (
  "_id" INT PRIMARY KEY,
  "channel_id" INT,
  "description" VARCHAR,
  "created_at" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  "modified_at" TIMESTAMP
);

CREATE TABLE "playlist" (
  "_id" INT PRIMARY KEY,
  "channel_id" INT UNIQUE,
  "name" VARCHAR(255),
  "is_public" BOOLEAN DEFAULT false,
  "created_at" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  "modified_at" TIMESTAMP
);

CREATE TABLE "channel_videos" (
  "_id" INT PRIMARY KEY,
  "channel_id" INT UNIQUE,
  "title" VARCHAR(64),
  "description" VARCHAR,
  "is_premier" BOOLEAN DEFAULT false,
  "is_participant" BOOLEAN DEFAULT false,
  "created_at" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  "modified_at" TIMESTAMP
);

CREATE TABLE "channel_video_comments" (
  "_id" INT PRIMARY KEY,
  "channel_id" INT,
  "video_id" INT,
  "description" VARCHAR,
  "is_reported" BOOLEAN DEFAULT false,
  "created_at" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  "modified_at" TIMESTAMP
);

CREATE TABLE "channel_video_sub_comments" (
  "_id" INT PRIMARY KEY,
  "channel_id" INT,
  "comment_id" INT,
  "description" VARCHAR,
  "is_reported" BOOLEAN DEFAULT false,
  "created_at" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  "modified_at" TIMESTAMP
);

CREATE TABLE "playlist_videos" (
  "_id" INT PRIMARY KEY,
  "playlist_id" INT,
  "channel_video_id" INT,
  "created_at" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  "modified_at" TIMESTAMP
);

CREATE TABLE "channel_history" (
  "_id" INT PRIMARY KEY,
  "channel_id" INT,
  "channel_video_id" INT,
  "created_at" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  "modified_at" TIMESTAMP
);

CREATE TABLE "subscriptions" (
  "_id" INT PRIMARY KEY,
  "channel_id" INT,
  "subscribed_channel_id" INT,
  "subscription_type_id" INT,
  "created_at" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  "modified_at" TIMESTAMP
);

CREATE TABLE "subscription_types" (
  "_id" INT PRIMARY KEY,
  "text" VARCHAR DEFAULT 'NORMAL',
  "created_at" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  "modified_at" TIMESTAMP
);

CREATE TABLE "roles" (
  "_id" INT PRIMARY KEY,
  "text" VARCHAR DEFAULT 'USER',
  "created_at" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  "modified_at" TIMESTAMP
);

ALTER TABLE "channel_announcements" ADD FOREIGN KEY ("channel_id") REFERENCES "channel" ("_id");

ALTER TABLE "channel_video_comments" ADD FOREIGN KEY ("video_id") REFERENCES "channel_videos" ("_id");

ALTER TABLE "channel_video_comments" ADD FOREIGN KEY ("channel_id") REFERENCES "channel" ("_id");

ALTER TABLE "channel_video_sub_comments" ADD FOREIGN KEY ("comment_id") REFERENCES "channel_video_comments" ("_id");

ALTER TABLE "channel_video_sub_comments" ADD FOREIGN KEY ("channel_id") REFERENCES "channel" ("_id");

ALTER TABLE "channel" ADD FOREIGN KEY ("account_id") REFERENCES "accounts" ("_id");

ALTER TABLE "channel_videos" ADD FOREIGN KEY ("channel_id") REFERENCES "channel" ("_id");

ALTER TABLE "playlist" ADD FOREIGN KEY ("channel_id") REFERENCES "channel" ("_id");

ALTER TABLE "playlist_videos" ADD FOREIGN KEY ("playlist_id") REFERENCES "playlist" ("_id");

ALTER TABLE "playlist_videos" ADD FOREIGN KEY ("channel_video_id") REFERENCES "channel_videos" ("_id");

ALTER TABLE "channel_history" ADD FOREIGN KEY ("channel_id") REFERENCES "channel" ("_id");

ALTER TABLE "channel_history" ADD FOREIGN KEY ("channel_video_id") REFERENCES "channel_videos" ("_id");

ALTER TABLE "subscriptions" ADD FOREIGN KEY ("subscription_type_id") REFERENCES "subscription_types" ("_id");

ALTER TABLE "subscriptions" ADD FOREIGN KEY ("channel_id") REFERENCES "channel" ("_id");

ALTER TABLE "channel" ADD FOREIGN KEY ("role_id") REFERENCES "roles" ("_id");
