# Andreas Distribution SRL - React Catalog

Site vitrină/catalog pentru distribuitor cosmetice multibrand.

## Tehnologii

- React + Vite
- Tailwind CSS
- Supabase: database, auth, storage
- Vercel deploy

## Instalare locală

```bash
npm install
cp .env.example .env
npm run dev
```

Completează `.env` cu valorile din Supabase > Settings > API:

```env
VITE_SUPABASE_URL=...
VITE_SUPABASE_ANON_KEY=...
```

## Configurare Supabase

1. Creează proiect nou în Supabase.
2. Mergi la SQL Editor.
3. Rulează conținutul din `supabase/schema.sql`.
4. Mergi la Authentication > Users > Add user și creează administratorul.
5. Pornește aplicația și intră la `/admin/login`.

## Deploy pe Vercel

1. Urcă proiectul pe GitHub.
2. Creează proiect nou în Vercel și conectează repository-ul.
3. Adaugă Environment Variables:
   - `VITE_SUPABASE_URL`
   - `VITE_SUPABASE_ANON_KEY`
4. Deploy.

## Pagini

- `/` - pagina principală
- `/catalog` - catalog produse
- `/branduri` - branduri
- `/despre` - despre companie
- `/contact` - contact
- `/admin/login` - login administrator
- `/admin` - dashboard
- `/admin/produse` - gestionare produse
- `/admin/branduri` - gestionare branduri
- `/admin/categorii` - gestionare categorii
- `/admin/setari` - setări companie

## Observații

- Tabelele Supabase nu se creează automat. Trebuie rulat scriptul SQL.
- Imaginile se încarcă în Supabase Storage.
- Pentru formular contact real, se poate adăuga ulterior EmailJS, Resend sau Supabase Edge Function.
