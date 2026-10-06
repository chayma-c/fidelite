BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "device_token" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid NOT NULL,
    "fcmToken" text NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "fidelite_order" ADD COLUMN "customerUserId" uuid;
ALTER TABLE "fidelite_order" ADD COLUMN "handledAt" timestamp without time zone;
ALTER TABLE "fidelite_order" ALTER COLUMN "staffUserId" DROP NOT NULL;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "online_order_settings" (
    "id" bigserial PRIMARY KEY,
    "autoPrintEnabled" boolean NOT NULL DEFAULT false,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "device_token"
    ADD CONSTRAINT "device_token_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "fidelite_order"
    ADD CONSTRAINT "fidelite_order_fk_1"
    FOREIGN KEY("customerUserId")
    REFERENCES "app_user"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR fidelite
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('fidelite', '20261006182957621', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261006182957621', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();


COMMIT;
