BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "points_ledger_entry" DROP CONSTRAINT IF EXISTS "points_ledger_entry_fk_2";
ALTER TABLE "points_ledger_entry" ADD COLUMN "relatedRedemptionId" bigint;
ALTER TABLE "points_ledger_entry" ALTER COLUMN "relatedOrderId" DROP NOT NULL;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "redemption" (
    "id" bigserial PRIMARY KEY,
    "customerUserId" uuid NOT NULL,
    "staffUserId" uuid NOT NULL,
    "rewardItemId" bigint NOT NULL,
    "rewardNameSnapshot" text NOT NULL,
    "pointsCostSnapshot" bigint NOT NULL,
    "status" text NOT NULL DEFAULT 'completed'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reward_item" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "description" text,
    "pointsCost" bigint NOT NULL,
    "isActive" boolean NOT NULL DEFAULT true,
    "stock" bigint,
    "sortOrder" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "wallet_token" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid NOT NULL,
    "tokenHash" text NOT NULL,
    "issuedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" timestamp without time zone NOT NULL,
    "consumedAt" timestamp without time zone,
    "consumedByRedemptionId" bigint
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "points_ledger_entry"
    ADD CONSTRAINT "points_ledger_entry_fk_3"
    FOREIGN KEY("createdByUserId")
    REFERENCES "app_user"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "points_ledger_entry"
    ADD CONSTRAINT "points_ledger_entry_fk_2"
    FOREIGN KEY("relatedRedemptionId")
    REFERENCES "redemption"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "redemption"
    ADD CONSTRAINT "redemption_fk_0"
    FOREIGN KEY("customerUserId")
    REFERENCES "app_user"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "redemption"
    ADD CONSTRAINT "redemption_fk_1"
    FOREIGN KEY("staffUserId")
    REFERENCES "app_user"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "redemption"
    ADD CONSTRAINT "redemption_fk_2"
    FOREIGN KEY("rewardItemId")
    REFERENCES "reward_item"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "wallet_token"
    ADD CONSTRAINT "wallet_token_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "wallet_token"
    ADD CONSTRAINT "wallet_token_fk_1"
    FOREIGN KEY("consumedByRedemptionId")
    REFERENCES "redemption"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR fidelite
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('fidelite', '20260911135645132', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260911135645132', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();


COMMIT;
