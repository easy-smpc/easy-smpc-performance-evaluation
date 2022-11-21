-- Change to db
\c easybackend;

-- Delete if exists
DROP TABLE IF EXISTS message;
DROP SEQUENCE IF EXISTS public.message_id_seq;
 
-- Create table
CREATE TABLE "message" (
	"id" INTEGER NOT NULL,
	"receiver" TEXT NOT NULL DEFAULT '',
	"scope" TEXT NOT NULL DEFAULT '',
	"content" TEXT NOT NULL DEFAULT '', PRIMARY KEY ("id")
);

-- 
-- Create and alter index and sequence
CREATE INDEX userscopeidx ON public.message USING btree ("receiver", "scope");
CREATE SEQUENCE public.message_id_seq AS INTEGER START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER TABLE ONLY public.message ALTER COLUMN id SET DEFAULT nextval('public.message_id_seq':: REGCLASS);