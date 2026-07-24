// Padel Knowledge Graph — Example Cypher Queries
// Graph built in Neo4j: 10 node classes (Igrac, Turnir, Lokacija, Brend,
// Oprema, Udarac, Pozicija, Teren, Pravilo) — 64 nodes, 256 relationships.

// ── Simple queries ──────────────────────────────────────────────

// 1. All brand sponsorships: which brand sponsors which player.
MATCH (b:Brend)-[:SPONZORIRA]->(i:Igrac)
RETURN b.naziv, i.naziv;

// 2. All tournaments in the graph.
MATCH (t:Turnir)
RETURN t.naziv;

// ── Complex queries ─────────────────────────────────────────────

// 3. Which brands sponsor players from Spain?
MATCH (b:Brend)-[:SPONZORIRA]->(i:Igrac)-[:DOLAZI_IZ]->(l:Lokacija)
WHERE l.naziv = 'Španjolska'
RETURN b.naziv, i.naziv, l.naziv;

// 4. Player pairs who are partners and come from the same country.
MATCH (i1:Igrac)-[:PARTNER]->(i2:Igrac),
      (i1)-[:DOLAZI_IZ]->(l:Lokacija),
      (i2)-[:DOLAZI_IZ]->(l)
RETURN i1.naziv AS Igrac1, i2.naziv AS Igrac2, l.naziv AS Zemlja;

// 5. Players, the equipment they use, its manufacturer, and their home country.
MATCH (i:Igrac)-[:KORISTI]->(r:Reket)<-[:PROIZVODI]-(b:Brend),
      (i)-[:DOLAZI_IZ]->(l:Lokacija)
RETURN i.naziv AS Igrac, r.naziv AS Reket, b.naziv AS Brend, l.naziv AS Zemlja;
