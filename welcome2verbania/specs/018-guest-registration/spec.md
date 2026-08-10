# Feature Specification: Guest Registration Section in House Rules

**Feature Branch**: `018-guest-registration`
**Created**: 2026-08-10
**Status**: IMPLEMENTED
**Input**: Add a new "Guest Registration" info card in House Rules, positioned before the City Tax card. Explains the Italian legal requirement to register all guests on the regional tourism platform and asks guests to send ID/passport copies before arrival. All five languages (EN/IT/DE/ES/FR) implemented in the same release.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Guest Reads Registration Requirement (Priority: P1)

A guest opens House Rules and finds a clear notice that Italian law requires
registration on the regional tourism platform, with a request to send ID/passport
copies before arrival via Airbnb messenger or WhatsApp.

**Why this priority**: Legal compliance — the owner is required to register all
guests. Without this notice, guests may be surprised by the request or fail to
provide documents in time.

**Independent Test**: Open `index.html`, navigate to House Rules. A "Guest
Registration" card appears after the Smoking card and before the City Tax card
in all five languages.

**Acceptance Scenarios**:

1. **Given** the guest opens House Rules, **When** they scroll, **Then** the
   Guest Registration card appears between Smoking and City Tax.
2. **Given** the guest reads the card, **Then** they understand they must send
   ID/passport of all guests before arrival via Airbnb messenger or WhatsApp.
3. **Given** the guest switches language, **Then** the card text appears in the
   selected language.

---

### Edge Cases

- Card uses `info` type (no border-left, no beige background) consistent with
  other informational cards.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: A new card `{ titleKey: 'rules_registration_title', bodyKey: 'rules_registration_body', type: 'info' }` MUST be inserted in the `rules` array in `renderHouseRules()` between the Smoking card and the City Tax card.
- **FR-002**: Content strings MUST be defined in all five languages in `CONTENT.strings`.
- **FR-003**: No structural changes to other cards are required.

### Key Entities

- **`CONTENT.strings.{lang}.rules_registration_title`** — card title
- **`CONTENT.strings.{lang}.rules_registration_body`** — card body

## Success Criteria *(mandatory)*

- **SC-001**: Guest Registration card appears between Smoking and City Tax in all five languages.
- **SC-002**: Text is accurate and complete in all languages.

## Assumptions

- Card type is `info` (not `warning`) — it is an informational notice, not a prohibition.
- The Airbnb messenger and WhatsApp channels are the intended communication methods.

## Seed Content

| Lang | Title | Body |
|---|---|---|
| EN | `📋 Guest Registration` | According to Italian law, all guests must be registered on the regional tourism platform. For this reason, I kindly ask you to send me a copy of the ID card or passport of all guests before arrival, using Airbnb messenger or WhatsApp. |
| IT | `📋 Registrazione Ospiti` | Ai sensi della legge italiana, tutti gli ospiti devono essere registrati sulla piattaforma turistica regionale. Per questo motivo, vi chiedo gentilmente di inviarmi una copia del documento d'identità o del passaporto di tutti gli ospiti prima dell'arrivo, tramite il messenger di Airbnb o WhatsApp. |
| DE | `📋 Gästeanmeldung` | Gemäß dem italienischen Gesetz müssen alle Gäste auf der regionalen Tourismusplattform registriert werden. Aus diesem Grund bitte ich Sie, mir vor der Ankunft eine Kopie des Personalausweises oder Reisepasses aller Gäste über den Airbnb-Messenger oder WhatsApp zuzusenden. |
| ES | `📋 Registro de Huéspedes` | Según la ley italiana, todos los huéspedes deben estar registrados en la plataforma regional de turismo. Por este motivo, le pido amablemente que me envíe una copia del documento de identidad o pasaporte de todos los huéspedes antes de la llegada, a través del messenger de Airbnb o WhatsApp. |
| FR | `📋 Enregistrement des Hôtes` | Conformément à la loi italienne, tous les hôtes doivent être enregistrés sur la plateforme régionale de tourisme. Pour cette raison, je vous demande de bien vouloir m'envoyer une copie de la carte d'identité ou du passeport de tous les hôtes avant l'arrivée, via la messagerie Airbnb ou WhatsApp. |
