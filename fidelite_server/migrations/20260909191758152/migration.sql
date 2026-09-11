BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "fidelite_order" (
    "id" bigserial PRIMARY KEY,
    "staffUserId" uuid NOT NULL,
    "status" text NOT NULL DEFAULT 'confirmed'::text,
    "subtotalMillimes" bigint NOT NULL,
    "totalMillimes" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "menu_item" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "description" text,
    "priceMillimes" bigint NOT NULL,
    "category" text NOT NULL,
    "isActive" boolean NOT NULL DEFAULT true,
    "sortOrder" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "order_item" (
    "id" bigserial PRIMARY KEY,
    "orderId" bigint NOT NULL,
    "menuItemId" bigint NOT NULL,
    "menuItemNameSnapshot" text NOT NULL,
    "unitPriceMillimesSnapshot" bigint NOT NULL,
    "quantity" bigint NOT NULL,
    "lineTotalMillimes" bigint NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "fidelite_order"
    ADD CONSTRAINT "fidelite_order_fk_0"
    FOREIGN KEY("staffUserId")
    REFERENCES "app_user"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "order_item"
    ADD CONSTRAINT "order_item_fk_0"
    FOREIGN KEY("orderId")
    REFERENCES "fidelite_order"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "order_item"
    ADD CONSTRAINT "order_item_fk_1"
    FOREIGN KEY("menuItemId")
    REFERENCES "menu_item"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR fidelite
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('fidelite', '20260909191758152', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260909191758152', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();


COMMIT;
