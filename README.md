# Maud Lewis Letter to Mr. Kinnear (February 13, 1967)
## A Collaborative TEI P5 Digital Scholarly Edition

[![TEI XML Validation Gate](https://github.com/kmpenner/rels-398-demo/actions/workflows/validate.yml/badge.svg)](https://github.com/kmpenner/rels-398-demo/actions/workflows/validate.yml)
[![Schema: TEI P5 msdesc.rng](https://img.shields.io/badge/schema-TEI%20P5%20msdesc.rng-blue)](msdesc.rng)
[![Licence: CC BY-SA 4.0](https://img.shields.io/badge/licence-CC%20BY--SA%204.0-lightgrey)](https://creativecommons.org/licenses/by-sa/4.0/)

This repository serves as the reference and live demonstration digital scholarly edition for **RELS 398.10 / ENGL 398.10 (Digital Methods for Historical Documents)** at St. Francis Xavier University.

It demonstrates the transition from solitary desktop markup to distributed, multi-editor collaborative scholarship using Git, GitHub remotes, pull requests as scholarly apparatus, and conflict resolution in TEI XML.

---

## 1. Primary Witness and Archival Context

- **Witness:** Autograph letter from Nova Scotia folk artist Maud Lewis (1903–1970) to John Kinnear, written from Marshalltown, Digby County, Nova Scotia.
- **Physical Document:** Single lined stationery leaf written in blue ballpoint ink, preserved in a private collection.
- **Facsimile:** High-resolution digital scan included as [`letter.jpg`](letter.jpg).
- **Core Edition File:** Consolidated TEI P5 XML master file at [`witness.xml`](witness.xml).

---

## 2. Accumulated Encoding Layers (Modules 1–9)

This edition consolidates nine discrete methodological layers authored throughout the semester:

1. **Codicological Metadata (`teiHeader`):** Detailed repository, physical description (`physDesc`), and historical provenance records.
2. **Digital Facsimile (`facsimile`):** Surface mapping and coordinate linking to the primary witness scan.
3. **Diplomatic Transcription (`text/body`):** Line-by-line transcription preserving autograph layout and orthography.
4. **AI-Reconciled Text:** Audited transcription reconciling independent manual and model-assisted passes.
5. **Orthographic Regularization (`choice`):** Preserving vernacular spellings (`<orig>`) alongside standardized forms (`<reg>`) without flattening the artist's regional voice.
6. **Reading Stylesheets (`cetei.css`):** Responsive typographic presentation toggling between diplomatic and normalized reading views.
7. **Linguistic Markup (`w`, `pos`, `lemma`):** Morphological and part-of-speech tagging.
8. **Named Entities (`persName`, `placeName`, `date`):** Authority record linking to VIAF and GeoNames.
9. **Revision History (`revisionDesc`):** Self-contained scholarly audit trail logging editorial changes, dates, and contributor IDs.

---

## 3. Collaborative Workflow & Governance

In digital scholarly editing, distributed version control replaces unversioned file exchanges by email with an immutable, transparent record of all editorial interventions.

### Branch Naming Conventions
Never commit directly to the `main` branch. All editorial proposals must be developed on categorized feature branches:
- `feature/<description>`: Substantial new encoding layer, section, or annotation (e.g., `feature/date-audit`, `feature/french-entities`).
- `fix/<description>`: Correcting a transcription error, broken attribute, or schema violation (e.g., `fix/maud-lewis-date-when`).
- `docs/<description>`: Updating documentation, collation reports, or editorial guidelines (e.g., `docs/citation-guide`).

### Pull Requests as Scholarly Apparatus
A GitHub Pull Request functions as a living *apparatus criticus*. It attaches critical debate, paleographical evidence, and validation checks directly to proposed commit diffs before text enters the master edition:
- Every PR automatically uses the pre-flight checklist defined in [`.github/PULL_REQUEST_TEMPLATE.md`](.github/PULL_REQUEST_TEMPLATE.md).
- Authors must cite manuscript coordinates and verify zero schema errors before requesting review.

### Conflict Resolution Protocol
When concurrent edits modify the same XML lines:
1. Do not blindly choose "Accept Current" or "Accept Incoming" in VS Code.
2. Synthesize complementary scholarly contributions into an integrated reading.
3. Delete all Git conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`).
4. **Enforce the Syntax Gate:** Run `xmllint --noout witness.xml` before staging. A single surviving marker character invalidates the entire edition.
5. Record a descriptive merge commit: `git commit -m "Merge branch 'feature/...': synthesize date attributes"`.

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
