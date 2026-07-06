import {Link,NavLink,Outlet} from 'react-router-dom'

export default function PublicLayout(){
  const nav=({isActive})=>`transition hover:text-[#b38b45] ${isActive?'text-[#b38b45]':'text-white/78'}`
  return <div className="min-h-screen flex flex-col">
    <header className="bg-[#18120f]/95 text-white sticky top-0 z-40 backdrop-blur border-b border-white/10">
      <div className="container py-4 flex flex-col md:flex-row gap-4 md:items-center md:justify-between">
        <Link to="/" className="flex items-center gap-3">
          <span className="h-10 w-10 rounded-full bg-gradient-to-br from-[#d7b66f] to-[#8b6428] grid place-items-center font-display text-xl">A</span>
          <span>
            <span className="block font-display text-2xl tracking-wide leading-none">Andreas Distribution</span>
            <span className="text-[11px] uppercase tracking-[.24em] text-white/50">Beauty distributor</span>
          </span>
        </Link>
        <nav className="flex flex-wrap gap-5 text-sm font-semibold">
          <NavLink className={nav} to="/">Acasă</NavLink>
          <NavLink className={nav} to="/catalog">Catalog</NavLink>
          <NavLink className={nav} to="/branduri">Branduri</NavLink>
          <NavLink className={nav} to="/despre">Despre</NavLink>
          <NavLink className={nav} to="/contact">Contact</NavLink>
          <NavLink className={nav} to="/admin">Admin</NavLink>
        </nav>
      </div>
    </header>
    <main className="flex-1"><Outlet/></main>
    <footer className="bg-[#18120f] text-white mt-20">
      <div className="container py-12 grid md:grid-cols-3 gap-8 text-sm">
        <div><h3 className="font-display text-2xl mb-3">Andreas Distribution SRL</h3><p className="text-white/65 leading-6">Distribuitor cosmetice multibrand, București, România. Catalog B2B pentru branduri premium.</p></div>
        <div><h4 className="font-bold mb-3 text-[#d7b66f]">Branduri</h4><p className="text-white/65">La Sultane de Saba · Age Stop</p></div>
        <div><h4 className="font-bold mb-3 text-[#d7b66f]">Contact</h4><p className="text-white/65">Actualizează datele în Admin → Setări.</p></div>
      </div>
    </footer>
  </div>
}
