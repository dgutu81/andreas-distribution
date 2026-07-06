import {supabase} from '../lib/supabaseClient';import {slugify} from '../lib/helpers'
export async function uploadFile(bucket,file){if(!file)return '';const ext=file.name.split('.').pop();const path=`${Date.now()}-${Math.random().toString(36).slice(2)}.${ext}`;const{error}=await supabase.storage.from(bucket).upload(path,file,{upsert:false});if(error)throw error;return supabase.storage.from(bucket).getPublicUrl(path).data.publicUrl}
export {slugify}
