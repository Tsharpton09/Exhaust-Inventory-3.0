-- Supabase setup for Exhaust Inventory
-- Run in Supabase SQL Editor if the `inventory` table does not already exist.
create table if not exists public.inventory (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  part text not null,
  make text not null,
  order_link text,
  stock integer not null default 0,
  recommended integer not null default 0,
  created_at timestamptz not null default now()
);

alter table public.inventory enable row level security;

-- This app currently has no user authentication. These policies allow the
-- browser's publishable/anon client to perform the CRUD operations the app uses.
-- Only use these policies if the inventory is intentionally public/shared.
drop policy if exists "inventory_select_public" on public.inventory;
drop policy if exists "inventory_insert_public" on public.inventory;
drop policy if exists "inventory_update_public" on public.inventory;
drop policy if exists "inventory_delete_public" on public.inventory;

create policy "inventory_select_public" on public.inventory for select to anon, authenticated using (true);
create policy "inventory_insert_public" on public.inventory for insert to anon, authenticated with check (true);
create policy "inventory_update_public" on public.inventory for update to anon, authenticated using (true) with check (true);
create policy "inventory_delete_public" on public.inventory for delete to anon, authenticated using (true);
