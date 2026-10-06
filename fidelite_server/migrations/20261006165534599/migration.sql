BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "shop_status" (
    "id" bigserial PRIMARY KEY,
    "status" text NOT NULL DEFAULT 'open'::text,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);


--
-- MIGRATION VERSION FOR fidelite
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('fidelite', '20261006165534599', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261006165534599', "timestamp" = now();

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
