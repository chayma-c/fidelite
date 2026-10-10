BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "fidelite_order" ADD COLUMN "fulfillmentMethod" text;
ALTER TABLE "fidelite_order" ADD COLUMN "paymentMethod" text;
ALTER TABLE "fidelite_order" ADD COLUMN "deliveryFeeMillimes" bigint NOT NULL DEFAULT 0;
ALTER TABLE "fidelite_order" ADD COLUMN "deliveryAddress" text;
ALTER TABLE "fidelite_order" ADD COLUMN "deliveryPhone" text;

--
-- MIGRATION VERSION FOR fidelite
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('fidelite', '20261010092120304', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261010092120304', "timestamp" = now();

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
