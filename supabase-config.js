// ============================================
// SUPABASE INTEGRATION FOR PLANNING 2026
// ============================================
// 
// Instructions:
// 1. Create a Supabase account at https://supabase.com
// 2. Create a new project
// 3. In SQL Editor, run the schema.sql script
// 4. Get your SUPABASE_URL and anon key from Settings > API
// 5. Replace the values below
// 6. Include this file in index.html before the main script
//
// <script src="supabase-config.js"></script>

const SUPABASE_CONFIG = {
  url: "https://YOUR_PROJECT_ID.supabase.co",
  anonKey: "YOUR_ANON_KEY_HERE"
};

// Initialize Supabase client
let supabaseClient = null;

async function initSupabase() {
  if (supabaseClient) return supabaseClient;
  
  const { createClient } = await import('https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2');
  supabaseClient = createClient(SUPABASE_CONFIG.url, SUPABASE_CONFIG.anonKey);
  
  return supabaseClient;
}

// Override the storage functions in main script
async function readStateSupabase() {
  const supabase = await initSupabase();
  
  try {
    const { data, error } = await supabase
      .from('planning_data')
      .select('data')
      .eq('key', STORAGE_KEY)
      .single();
    
    if (error) throw new Error(error.message);
    if (!data) throw new Error("empty");
    
    const parsed = JSON.parse(data.data);
    if (parsed.plan) state.plan = parsed.plan;
    if (parsed.team) state.team = parsed.team;
  } catch (e) {
    console.error("readStateSupabase error:", e);
    throw e;
  }
}

async function saveSupabase() {
  const supabase = await initSupabase();
  setStatus("saving", "Enregistrement…");
  
  try {
    const { error } = await supabase
      .from('planning_data')
      .upsert({
        key: STORAGE_KEY,
        data: JSON.stringify(state),
        updated_at: new Date().toISOString()
      }, {
        onConflict: 'key'
      });
    
    if (error) throw error;
    
    setStatus("ok", "Enregistré ✓");
    return true;
  } catch (e) {
    console.error("saveSupabase error:", e);
    setStatus("error", "⚠ Échec de l'enregistrement");
    toast("⚠ L'enregistrement a échoué");
    return false;
  }
}

// Export for use in main script
window.supabaseConfig = {
  readState: readStateSupabase,
  save: saveSupabase,
  init: initSupabase
};
