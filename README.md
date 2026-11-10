# Louis XVI's Address to the Assemblée Nationale (31 December 1791)
## A Collaborative TEI P5 Digital Scholarly Edition

[![TEI XML Validation Gate](https://github.com/kmpenner/rels-398-demo/actions/workflows/validate.yml/badge.svg)](https://github.com/kmpenner/rels-398-demo/actions/workflows/validate.yml)
[![Schema: TEI P5 msdesc.rng](https://img.shields.io/badge/schema-TEI%20P5%20msdesc.rng-blue)](msdesc.rng)
[![Licence: CC BY 4.0](https://img.shields.io/badge/licence-CC%20BY%204.0-lightgrey)](https://creativecommons.org/licenses/by/4.0/)

This repository serves as the reference and live demonstration digital scholarly edition for **RELS 398.10 / ENGL 398.10 (Digital Methods for Historical Documents)** at St. Francis Xavier University, featuring **Ace Long's edition of British Library Zweig MS 169**.

It demonstrates the transition from solitary desktop markup to distributed, multi-editor collaborative scholarship using Git, GitHub remotes, pull requests as scholarly apparatus, and merge conflict adjudication in TEI XML.

---

## 1. Primary Witness and Archival Context

- **Witness:** Autograph message from King Louis XVI to the *Assemblée Nationale*, dated *31 xbre 1791* (31 December 1791), concerning the imperial note delivered to the French Ambassador in Vienna regarding émigré assemblies on the territory of the Elector of Trier.
- **Physical Document:** Single paper leaf written in brown iron-gall ink in 18th-century French chancery cursive (`British Library, Western Manuscripts, Zweig MS 169`).
- **Facsimile:** High-resolution digital scan included as [`decree.jpg`](decree.jpg) (BL IIIF manifest: `ark:/81055/vdc_100139607660.0x000001`).
- **Core Edition File:** Consolidated TEI P5 XML master file at [`witness.xml`](witness.xml).

---

## 2. Accumulated Encoding Layers (Modules 1–9)

This edition consolidates the methodological layers authored throughout the semester:

1. **Codicological Metadata (`teiHeader`):** Repository (`British Library`), shelfmark (`Zweig MS 169`), physical description (`physDesc`), and provenance records.
2. **Digital Facsimile (`facsimile`):** Surface mapping (`f1r`) and `<zone>` coordinate linking to the primary witness scan.
3. **Diplomatic Transcription (`text/body`):** Line-by-line transcription preserving autograph layout, suspension (`xbre`), and marginal gaps.
4. **AI-Reconciled Text:** Audited transcription reconciling independent manual and model-assisted passes.
5. **Orthographic Regularization (`choice`):** Expanding `xbre` -> `décembre`, regularizing 18th-century `-ois`/`-oit` -> `-ais`/`-ait` per the 1835 Académie française reform, and restoring missing accents while preserving invariant nouns (`droit`).
6. **Reading Stylesheets (`cetei.css`):** Typographic presentation toggling between diplomatic and normalized reading views.
7. **Named Entities (`orgName`, `persName`, `placeName`, `date`):** Ten verified historical entities linked to Wikidata (`Q780457`, `Q2976897`, `Q151321`, `Q3052789`, `Q565780`, `Q700283`, `Q1794352`) and GeoNames (`2761369`, `3017382`).
8. **Revision History (`revisionDesc`):** Self-contained scholarly audit trail logging editorial changes, dates, and contributor IDs.

---

## 3. Collaborative Workflow & Governance

In digital scholarly editing, distributed version control replaces unversioned file exchanges by email with an immutable, transparent record of all editorial interventions.

### Branch Naming Conventions
Never commit directly to the `main` branch. All editorial proposals must be developed on categorized feature branches:
- `feature/<description>`: Substantial new encoding layer, section, or annotation (e.g., `feature/french-entities`, `feature/date-audit`).
- `fix/<description>`: Correcting a transcription typo, broken attribute, or schema violation (e.g., `fix/assembly-wikidata-id`).
- `docs/<description>`: Updating documentation, collation reports, or editorial guidelines.

### Pull Requests as Scholarly Apparatus
A GitHub Pull Request functions as a living *apparatus criticus*. It attaches critical debate, paleographical evidence, and validation checks directly to proposed commit diffs before text enters the master edition:
- Every PR automatically uses the pre-flight checklist defined in [`.github/PULL_REQUEST_TEMPLATE.md`](.github/PULL_REQUEST_TEMPLATE.md).
- Authors must cite manuscript coordinates and verify zero schema errors before requesting review.

### Conflict Resolution Protocol
When concurrent edits modify the same XML lines:
1. Do not blindly choose "Accept Current" or "Accept Incoming" in VS Code.
2. Synthesize complementary scholarly contributions into an integrated reading (e.g., combining verified Wikidata authority `@ref` with classification `@type` and editorial attribution `@resp`).
3. Delete all Git conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`).
4. **Enforce the Syntax Gate:** Run `xmllint --noout witness.xml` before staging. A single surviving marker character invalidates the entire edition.
5. Record a descriptive merge commit: `git commit -m "Merge branch 'feature/french-entities': synthesize assembly markup"`.

---

## 4. Local Verification & Quality Gates

### Syntactic Well-Formedness
```bash
xmllint --noout witness.xml
```
*Exit code 0 confirms valid XML structure.*

### Relax NG Schema Validation
```bash
python3 - << 'EOF'
from lxml import etree
schema = etree.RelaxNG(etree.parse("msdesc.rng"))
doc = etree.parse("witness.xml")
if schema.validate(doc):
    print("VALID: witness.xml complies fully with msdesc.rng.")
else:
    for err in schema.error_log:
        print(err)
EOF
```

---

## 5. Live Demonstration Guide (Lesson 10.1)

For the detailed 50-minute classroom execution plan, terminal commands, and conflict simulation steps, refer to:
- [`DEMO_WALKTHROUGH.md`](DEMO_WALKTHROUGH.md)
- Reset helper script: [`reset_demo.sh`](reset_demo.sh)
