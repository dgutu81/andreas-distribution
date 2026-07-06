-- Andreas Distribution SRL - Supabase schema
-- Rulează tot scriptul în Supabase > SQL Editor > New query > Run

create extension if not exists pgcrypto;

create table if not exists brands (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  slug text unique not null,
  description text,
  logo text,
  cover_image text,
  website text,
  active boolean default true,
  created_at timestamptz default now()
);

create table if not exists categories (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  slug text unique not null,
  description text,
  parent_id uuid references categories(id) on delete set null,
  active boolean default true,
  created_at timestamptz default now()
);

create table if not exists products (
  id uuid primary key default gen_random_uuid(),
  brand_id uuid references brands(id) on delete set null,
  category_id uuid references categories(id) on delete set null,
  name text not null,
  slug text unique not null,
  short_description text,
  description text,
  ingredients text,
  directions text,
  image text,
  gallery jsonb default '[]'::jsonb,
  featured boolean default false,
  active boolean default true,
  seo_title text,
  seo_description text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table if not exists pages (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  slug text unique not null,
  content text,
  active boolean default true,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table if not exists settings (
  key text primary key,
  value text,
  updated_at timestamptz default now()
);

insert into brands(name, slug, description, active)
values
('La Sultane de Saba','la-sultane-de-saba','Brand premium de produse cosmetice inspirate din ritualuri orientale și experiențe spa.',true),
('Age Stop','age-stop','Brand cosmetic orientat spre îngrijire anti-aging și tratamente profesionale.',true)
on conflict (slug) do nothing;

insert into categories(name, slug, description, active)
values
('Îngrijire față','ingrijire-fata','Produse pentru rutina de îngrijire a tenului.',true),
('Îngrijire corp','ingrijire-corp','Produse pentru îngrijirea corpului.',true),
('Produse spa','produse-spa','Produse dedicate saloanelor și centrelor spa.',true),
('Anti-aging','anti-aging','Produse orientate spre îngrijire anti-aging.',true)
on conflict (slug) do nothing;

insert into settings(key,value)
values
('company_name','Andreas Distribution SRL'),
('email','contact@example.ro'),
('phone','+40 XXX XXX XXX'),
('address','București, România'),
('whatsapp',''),
('instagram',''),
('facebook','')
on conflict (key) do nothing;

-- Storage buckets publice pentru imagini
insert into storage.buckets (id, name, public)
values ('brands','brands',true), ('products','products',true), ('pages','pages',true)
on conflict (id) do nothing;

alter table brands enable row level security;
alter table categories enable row level security;
alter table products enable row level security;
alter table pages enable row level security;
alter table settings enable row level security;

-- Publicul poate citi doar conținut activ
create policy "Public read active brands" on brands for select using (active = true);
create policy "Public read active categories" on categories for select using (active = true);
create policy "Public read active products" on products for select using (active = true);
create policy "Public read active pages" on pages for select using (active = true);
create policy "Public read settings" on settings for select using (true);

-- Utilizatorii autentificați pot administra conținutul
create policy "Authenticated manage brands" on brands for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
create policy "Authenticated manage categories" on categories for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
create policy "Authenticated manage products" on products for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
create policy "Authenticated manage pages" on pages for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
create policy "Authenticated manage settings" on settings for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');

-- Storage policies
create policy "Public read brand images" on storage.objects for select using (bucket_id = 'brands');
create policy "Public read product images" on storage.objects for select using (bucket_id = 'products');
create policy "Public read page images" on storage.objects for select using (bucket_id = 'pages');
create policy "Authenticated upload brand images" on storage.objects for insert with check (bucket_id = 'brands' and auth.role() = 'authenticated');
create policy "Authenticated upload product images" on storage.objects for insert with check (bucket_id = 'products' and auth.role() = 'authenticated');
create policy "Authenticated upload page images" on storage.objects for insert with check (bucket_id = 'pages' and auth.role() = 'authenticated');
create policy "Authenticated update brand images" on storage.objects for update using (bucket_id = 'brands' and auth.role() = 'authenticated');
create policy "Authenticated update product images" on storage.objects for update using (bucket_id = 'products' and auth.role() = 'authenticated');
create policy "Authenticated delete images" on storage.objects for delete using (auth.role() = 'authenticated');
