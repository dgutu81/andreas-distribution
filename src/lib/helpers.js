export const slugify=(s='')=>s.toString().toLowerCase().trim().normalize('NFD').replace(/[\u0300-\u036f]/g,'').replace(/[^a-z0-9]+/g,'-').replace(/^-+|-+$/g,'')
export const placeholder='https://placehold.co/900x650/F8F3EC/1F1A17?text=Andreas+Distribution'
export function publicUrl(bucket,path){return path||''}
