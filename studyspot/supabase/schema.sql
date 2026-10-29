-- Run once in Supabase SQL editor. Keep service_role keys server-side only.
create table if not exists public.profiles (
 user_id uuid primary key references auth.users(id) on delete cascade,
 nickname text check(nickname is null or char_length(nickname) between 2 and 20),
 created_at timestamptz not null default now()
);
create table if not exists public.favorites (
 user_id uuid not null references auth.users(id) on delete cascade,
 place_id text not null,
 place_name text not null,
 place_address text,
 place_url text,
 created_at timestamptz not null default now(),
 primary key(user_id,place_id)
);
create table if not exists public.place_reports (
 id bigint generated always as identity primary key,
 user_id uuid not null references auth.users(id) on delete cascade,
 place_id text not null,
 reason text not null check(reason in ('incorrect','closed','unsafe','other')),
 created_at timestamptz not null default now()
);
alter table public.profiles enable row level security;
alter table public.favorites enable row level security;
alter table public.place_reports enable row level security;
drop policy if exists profiles_select_own on public.profiles;
drop policy if exists profiles_insert_own on public.profiles;
drop policy if exists profiles_update_own on public.profiles;
create policy profiles_select_own on public.profiles for select to authenticated using ((select auth.uid())=user_id);
create policy profiles_insert_own on public.profiles for insert to authenticated with check ((select auth.uid())=user_id);
create policy profiles_update_own on public.profiles for update to authenticated using ((select auth.uid())=user_id) with check ((select auth.uid())=user_id);
drop policy if exists favorites_select_own on public.favorites;
drop policy if exists favorites_insert_own on public.favorites;
drop policy if exists favorites_delete_own on public.favorites;
create policy favorites_select_own on public.favorites for select to authenticated using ((select auth.uid())=user_id);
create policy favorites_insert_own on public.favorites for insert to authenticated with check ((select auth.uid())=user_id);
create policy favorites_delete_own on public.favorites for delete to authenticated using ((select auth.uid())=user_id);
drop policy if exists reports_select_own on public.place_reports;
drop policy if exists reports_insert_own on public.place_reports;
create policy reports_select_own on public.place_reports for select to authenticated using ((select auth.uid())=user_id);
create policy reports_insert_own on public.place_reports for insert to authenticated with check ((select auth.uid())=user_id);
-- Moderation is required before enabling public user reviews.
