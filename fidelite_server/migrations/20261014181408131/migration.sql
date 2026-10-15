BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "ingredient" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "kind" text NOT NULL,
    "isActive" boolean NOT NULL DEFAULT true,
    "sortOrder" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "menu_item" ADD COLUMN "isCustomizable" boolean NOT NULL DEFAULT false;

--
-- ACTION ALTER TABLE (hand-edited: serverpod_cli's generated plan for this
-- one was DROP TABLE "order_item" CASCADE + recreate, which would have
-- destroyed every existing order_item row -- 893 of them at the time this
-- migration was written, real order history from testing, not disposable
-- seed data. A plain additive ADD COLUMN with a default achieves the same
-- resulting schema (matches generated definition.json: json NOT NULL /
-- json NOT NULL / text nullable) without losing any of it. Existing rows
-- correctly get empty removed-ingredients/added-sauces lists and a null
-- special request -- they genuinely never had any, since this column
-- didn't exist yet when they were placed.
--
ALTER TABLE "order_item" ADD COLUMN "removedIngredients" json NOT NULL DEFAULT '[]'::json;
ALTER TABLE "order_item" ADD COLUMN "addedSauces" json NOT NULL DEFAULT '[]'::json;
ALTER TABLE "order_item" ADD COLUMN "specialRequest" text;


--
-- MIGRATION VERSION FOR fidelite
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('fidelite', '20261014181408131', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261014181408131', "timestamp" = now();

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
