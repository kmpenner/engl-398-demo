## Summary of Changes
<!-- Concise imperative summary of what document, layer, or element this PR modifies -->
- **Document / Witness:** Louis XVI Address to the Assemblée Nationale (31 December 1791, BL Zweig MS 169)
- **Scope of Modification:** 

## Codicological and Paleographical Evidence
<!-- Verify primary witness facsimile coordinates, readings, or authority records -->
- [ ] Primary witness facsimile verified against British Library manuscript scan (`decree.jpg`)
- [ ] Authority records verified against Wikidata or GeoNames (e.g., `wikidata:Q780457`, `geonames:2761369`)
- [ ] Orthographic regularization verified (18th-c. `-ois`/`-oit` and diplomatic abbreviations like `xbre` = décembre)

## Schema and Validation Checklist
<!-- Mandatory quality gates before merge -->
- [ ] Syntactic well-formedness verified via `xmllint --noout witness.xml` (exit code 0)
- [ ] Schema validation verified against `msdesc.rng` with zero errors
- [ ] Zero Git conflict delimiter markers (`<<<<<<<`, `=======`, `>>>>>>>`) remaining in file
- [ ] `<revisionDesc>` updated with `<change>` tag recording date, editor ID, and PR rationale
