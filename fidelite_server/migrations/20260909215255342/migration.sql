BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "order_claim_token" (
    "id" bigserial PRIMARY KEY,
    "orderId" bigint NOT NULL,
    "tokenHash" text NOT NULL,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "issuedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" timestamp without time zone NOT NULL,
    "claimedAt" timestamp without time zone,
    "claimedByUserId" uuid
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "points_ledger_entry" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid NOT NULL,
    "deltaMillimes" bigint NOT NULL,
    "reason" text NOT NULL,
    "relatedOrderId" bigint NOT NULL,
    "balanceAfterMillimes" bigint NOT NULL,
    "createdByUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "order_claim_token"
    ADD CONSTRAINT "order_claim_token_fk_0"
    FOREIGN KEY("orderId")
    REFERENCES "fidelite_order"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "order_claim_token"
    ADD CONSTRAINT "order_claim_token_fk_1"
    FOREIGN KEY("claimedByUserId")
    REFERENCES "app_user"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "points_ledger_entry"
    ADD CONSTRAINT "points_ledger_entry_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "points_ledger_entry"
    ADD CONSTRAINT "points_ledger_entry_fk_1"
    FOREIGN KEY("relatedOrderId")
    REFERENCES "fidelite_order"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "points_ledger_entry"
    ADD CONSTRAINT "points_ledger_entry_fk_2"
    FOREIGN KEY("createdByUserId")
    REFERENCES "app_user"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR fidelite
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('fidelite', '20260909215255342', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260909215255342', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();


COMMIT;
