# Holiday Calendar iOS App — Development Rules

ဒီ project အတွက် development rules တွေကို step-by-step အလိုက် သတ်မှတ်ထားပါတယ်။
Implementation လုပ်တဲ့အခါ ဒီ rules တွေကို အတိအကျ လိုက်နာရပါမယ်။

---

## General Rules (အထွေထွေ စည်းမျဉ်းများ)

### Rule G1: Technology Stack
- Swift + SwiftUI + SwiftData + Swift Concurrency သာ သုံးရမယ်
- Flutter, React Native မသုံးရ
- Third-party libraries မလိုအပ်ဘဲ မထည့်ရ
- Apple native frameworks ကို ဦးစားပေးသုံးရမယ်

### Rule G2: Architecture Pattern
- MVVM (Model-View-ViewModel) pattern ကို follow လုပ်ရမယ်
- API calls ကို SwiftUI Views ထဲမှာ directly မထည့်ရ
- UI logic နဲ့ business logic ကို ခွဲခြားရမယ်
- ViewModels/Services ကို သင့်တော်သလို သုံးရမယ်

### Rule G3: Git Commit Strategy
- Step တစ်ခုပြီးတိုင်း git commit လုပ်ရမယ်
- Commit message format: `type: description`
- Types: `init`, `feat`, `fix`, `refactor`, `test`, `docs`
- Phase တစ်ခုပြီးတိုင်း build စစ်ပြီး test လုပ်ရမယ်
- တစ်ခုခု fail ရင် ရပ်ပြီး fix လုပ်ရမယ် — ဆက်မသွားရ

### Rule G4: File Modification
- Existing file ကို modify မလုပ်ခင် current contents ကို inspect လုပ်ရမယ်
- Existing comments/docstrings ကို ဖျက်မပစ်ရ
- Code ပြောင်းရင် related tests ကိုပါ update လုပ်ရမယ်

### Rule G5: State Management
- Loading, empty, error, offline states အားလုံးကို handle လုပ်ရမယ်
- async/await ကို prefer လုပ်ရမယ်
- Single source of truth principle ကို လိုက်နာရမယ်

### Rule G6: Development Order
- Phase တွေကို အစဉ်လိုက် implement လုပ်ရမယ်
- Backend ကို local iOS prototype အလုပ်လုပ်ပြီးမှ ဆောက်ရမယ်
- Phase အားလုံးကို တစ်ပြိုင်နက် implement မလုပ်ရ

---

## Step 1 Rules: Xcode Project Structure ဖန်တီးခြင်း

### Rule 1.1: Project Location
- Project ကို `/Users/kyawwaiyan/Desktop/todo-calendar-app/HolidayCalendar/` ထဲမှာ ဖန်တီးရမယ်
- Project name: `HolidayCalendar`

### Rule 1.2: Folder Structure
- Spec မှာ သတ်မှတ်ထားတဲ့ folder structure ကို အတိအကျ follow လုပ်ရမယ်
- Folders: `App/`, `Models/`, `Views/`, `ViewModels/`, `Services/`, `Persistence/`, `Network/`, `Resources/`
- Views subfolder: `Calendar/`, `Countries/`, `Todo/`, `Memo/`, `Settings/`

### Rule 1.3: Required Folders
```
HolidayCalendar/
├── App/
├── Models/
├── Views/
│   ├── Calendar/
│   ├── Countries/
│   ├── Todo/
│   ├── Memo/
│   └── Settings/
├── ViewModels/
├── Services/
├── Persistence/
├── Network/
└── Resources/
```

### Rule 1.4: Unnecessary Files
- မလိုအပ်တဲ့ files ဖန်တီးမရ
- Placeholder files တွေက minimal content ပဲ ပါရမယ်

### Rule 1.5: Git Commit
```
git add -A && git commit -m "init: create Xcode project structure"
```

---

## Step 2 Rules: TabView ဖန်တီးခြင်း

### Rule 2.1: Tab Count and Order
- Tab ၄ ခု ရှိရမယ် — ဒီထက် မပိုရ မနည်းရ
- အစဉ်: Calendar → Todo → Memo → Settings

### Rule 2.2: Default Tab
- App ဖွင့်ရင် Calendar tab ကို default selected ထားရမယ်

### Rule 2.3: SF Symbols
- Calendar tab: `calendar`
- Todo tab: `checkmark.circle`
- Memo tab: `note.text`
- Settings tab: `gearshape`

### Rule 2.4: Native Controls
- SwiftUI `TabView` ကိုပဲ သုံးရမယ်
- Custom tab bar implementation မလုပ်ရ (ဒီ phase မှာ)

### Rule 2.5: App Entry Point
- `HolidayCalendarApp.swift` ထဲမှာ `MainTabView()` ကို root view အနေနဲ့ set လုပ်ရမယ်

### Rule 2.6: MainTabView File Location
- File path: `Views/MainTabView.swift`

### Rule 2.7: Git Commit
```
git add -A && git commit -m "feat: add TabView with four tabs"
```

---

## Step 3 Rules: Placeholder Screens ဖန်တီးခြင်း

### Rule 3.1: Required Placeholder Views
- `CalendarView.swift` — Views/Calendar/
- `TodoListView.swift` — Views/Todo/
- `MemoListView.swift` — Views/Memo/
- `SettingsView.swift` — Views/Settings/

### Rule 3.2: NavigationStack
- Placeholder view တိုင်းမှာ `NavigationStack` ပါရမယ်
- `.navigationTitle()` set လုပ်ရမယ်

### Rule 3.3: Settings View Structure
- Settings view မှာ `List` ထဲ `NavigationLink("Countries")` ပါရမယ်
- CountrySelectionView ကို destination အနေနဲ့ link လုပ်ရမယ်

### Rule 3.4: Placeholder Content
- Placeholder views မှာ screen name ပြတဲ့ `Text` ပါရမယ်
- Complex UI ထည့်စရာ မလိုသေး

### Rule 3.5: Additional Placeholder Files
- `HolidayDetailView.swift` — Views/Calendar/
- `TodoDetailView.swift` — Views/Todo/
- `MemoDetailView.swift` — Views/Memo/
- ဒီ files တွေက empty placeholder ပဲ ဖြစ်ရမယ်

### Rule 3.6: Build Check
- ဒီ step ပြီးရင် app build ရရမယ် — error မရှိရ

### Rule 3.7: Git Commit
```
git add -A && git commit -m "feat: add placeholder screens for all tabs"
```

---

## Step 4 Rules: Country Data Model ဖန်တီးခြင်း

### Rule 4.1: Country struct Definition
- `struct Country` ကို သုံးရမယ် — `class` မသုံးရ
- Protocols: `Identifiable`, `Codable`, `Hashable`
- SwiftData `@Model` မသုံးရ Country အတွက်

### Rule 4.2: Required Properties
```swift
let id: String        // country code ကိုပဲ id အနေနဲ့ သုံး
let code: String      // ISO 3166-1 alpha-2
let name: String      // English name
let localName: String // Local language name
let flag: String      // Emoji flag
var isSelected: Bool  // User's selection state
let timezone: String  // Primary timezone
```

### Rule 4.3: Country Code as Identifier
- Country code (JP, MM, AU, KR, TH) ကို primary identifier အနေနဲ့ သုံးရမယ်
- Country name ကို primary identifier အနေနဲ့ မသုံးရ

### Rule 4.4: Initial Five Countries (Data Values)
| name | code | flag | localName | isSelected | timezone |
|------|------|------|-----------|------------|----------|
| Japan | JP | 🇯🇵 | 日本 | true | Asia/Tokyo |
| Myanmar | MM | 🇲🇲 | မြန်မာ | true | Asia/Yangon |
| Australia | AU | 🇦🇺 | Australia | false | Australia/Sydney |
| Korea | KR | 🇰🇷 | 대한민국 | false | Asia/Seoul |
| Thailand | TH | 🇹🇭 | ประเทศไทย | true | Asia/Bangkok |

### Rule 4.5: Korea Rule
- "Korea" = South Korea
- ISO code = KR
- North Korea ဖြစ်ခွင့်မရှိ
- နောက်မှ North Korea ထည့်ချင်ရင် KP code နဲ့ separate country ထည့်ရမယ်

### Rule 4.6: No Hard-coded Booleans
- `isJapanSelected`, `isMyanmarSelected` လို separate boolean variables မဖန်တီးရ
- Country model ကို collection/array အနေနဲ့ manage လုပ်ရမယ်

### Rule 4.7: Extensibility
- နိုင်ငံ ၆ ခုမြောက်၊ ၇ ခုမြောက် ထပ်ထည့်ရင် UI logic ပြန်ရေးစရာ မလိုရအောင် design လုပ်ရမယ်
- Country list ထဲ data ထပ်ထည့်လိုက်ယုံနဲ့ အလုပ်လုပ်ရမယ်

### Rule 4.8: Placeholder Models
- `Holiday.swift`, `Todo.swift`, `Memo.swift` — placeholder models ဖန်တီးရမယ်
- ဒီ models တွေကို နောက် Phase တွေမှာ implement လုပ်ပါမယ်

### Rule 4.9: Git Commit
```
git add -A && git commit -m "feat: add Country data model"
```

---

## Step 5 Rules: CountryViewModel ဖန်တီးခြင်း

### Rule 5.1: Observable Class
- `@Observable` macro သုံးရမယ် (iOS 17+ Observation framework)
- `ObservableObject + @Published` မသုံးရ (iOS 17+ target ဖြစ်လို့)

### Rule 5.2: Single Source of Truth
- `CountryViewModel` တစ်ခုတည်းက country selection state ကို manage လုပ်ရမယ်
- App-wide shared instance အနေနဲ့ `.environment()` ကနေ inject လုပ်ရမယ်

### Rule 5.3: Required Properties
```swift
private(set) var countries: [Country]           // All available countries
private var selectedCodesStorage: Set<String>    // Persisted selection
```

### Rule 5.4: Required Computed Properties
```swift
var countriesWithSelection: [Country]   // countries with correct isSelected
var selectedCountries: [Country]        // selected countries only
var selectedCountryCodes: Set<String>   // selected codes for filtering
```

### Rule 5.5: Required Methods
```swift
func toggleCountry(_ country: Country)  // Toggle one country
func selectAll()                         // Select all countries
func clearAll()                          // Deselect all countries
```

### Rule 5.6: Immediate UI Update
- `toggleCountry()` ခေါ်ရင် UI ချက်ချင်း update ဖြစ်ရမယ်
- @Observable ကြောင့် automatic re-render ဖြစ်ရမယ်

### Rule 5.7: Persistence Integration
- `init()` ထဲမှာ `loadSelectedCodes()` ခေါ်ရမယ်
- `selectedCodesStorage` ပြောင်းတိုင်း `saveSelectedCodes()` ခေါ်ရမယ်

### Rule 5.8: Default Selection
- First launch မှာ default: `["JP", "MM", "TH"]`
- UserDefaults ထဲမှာ data မရှိရင် ဒီ defaults ကို return ပြန်ရမယ်

### Rule 5.9: Placeholder ViewModels
- `CalendarViewModel.swift`, `TodoViewModel.swift`, `MemoViewModel.swift` — placeholder files ဖန်တီးရမယ်

### Rule 5.10: Git Commit
```
git add -A && git commit -m "feat: add CountryViewModel with initial countries and state management"
```

---

## Step 6 Rules: CountrySelectionView ဖန်တီးခြင်း

### Rule 6.1: Environment Access
- `@Environment(CountryViewModel.self)` ကနေ ViewModel ကို access လုပ်ရမယ်
- ViewModel ကို view ထဲမှာ create မလုပ်ရ

### Rule 6.2: List Structure
- SwiftUI `List` သုံးရမယ်
- Section 1: Select All / Clear All buttons
- Section 2: Country list (ForEach)

### Rule 6.3: Select All / Clear All
- ဒီ buttons တွေက visually dominant မဖြစ်ရ
- Main purpose က individual country selection ဖြစ်ရမယ်

### Rule 6.4: Country Row Contents
- Row တစ်ခုစီမှာ ပါရမယ်:
  1. Country flag (emoji) — `.font(.title2)`
  2. Country name (text)
  3. Toggle switch (native SwiftUI `Toggle`)

### Rule 6.5: Row Tap Behavior
- Row တစ်ခုလုံးကို tap လုပ်ရင် toggle ပြောင်းရမယ်
- Toggle ကိုပဲ tap လုပ်စရာ မလိုရ
- `.contentShape(Rectangle())` + `.onTapGesture` သုံးရမယ်

### Rule 6.6: Native Controls
- Native SwiftUI `Toggle` ကိုပဲ သုံးရမယ်
- Fake checkbox (arbitrary images) မသုံးရ — strong design reason မရှိရင်

### Rule 6.7: Navigation Title
- `.navigationTitle("Countries")` set လုပ်ရမယ်

### Rule 6.8: Immediate Calendar Update
- Country toggle ပြောင်းရင် Calendar view ချက်ချင်း update ဖြစ်ရမယ်
- Enable လုပ်ရင် ဒီ country ရဲ့ holidays ပေါ်ရမယ်
- Disable လုပ်ရင် ဒီ country ရဲ့ holidays ပျောက်ရမယ်

### Rule 6.9: Git Commit
```
git add -A && git commit -m "feat: add CountrySelectionView with toggle UI"
```

---

## Step 7 Rules: Country Selection Persistence ထည့်ခြင်း

### Rule 7.1: Persistence Method
- UserDefaults ကို သုံးရမယ် (country selection အတွက်)
- SwiftData ကို ဒီ data အတွက် မသုံးရ
- SwiftData ကို Todo, Memo, Holiday data တွေအတွက်သာ သုံးရမယ်

### Rule 7.2: Storage Key
- Key: `"selectedCountryCodes"`
- Value: JSON encoded `Set<String>` — e.g. `["JP", "MM", "TH"]`

### Rule 7.3: Save Logic
```swift
private func saveSelectedCodes() {
    if let data = try? JSONEncoder().encode(selectedCodesStorage) {
        UserDefaults.standard.set(data, forKey: "selectedCountryCodes")
    }
}
```

### Rule 7.4: Load Logic
```swift
private func loadSelectedCodes() -> Set<String> {
    guard let data = UserDefaults.standard.data(forKey: "selectedCountryCodes"),
          let codes = try? JSONDecoder().decode(Set<String>.self, from: data) else {
        return ["JP", "MM", "TH"]  // Default on first launch
    }
    return codes
}
```

### Rule 7.5: Persistence Test Requirements
- App ပိတ်ပြီး ပြန်ဖွင့်ရင် selection state ပြန်ရရမယ်
- ဥပမာ: Japan ON, Myanmar OFF, Australia ON, Korea ON, Thailand OFF → ပိတ်/ဖွင့် → same state

### Rule 7.6: Auto-save on Change
- `selectedCodesStorage` ပြောင်းတိုင်း auto-save ဖြစ်ရမယ်
- `didSet` observer သုံးရမယ်

### Rule 7.7: Git Commit
```
git add -A && git commit -m "feat: add country selection persistence with UserDefaults"
```

---

## Step 8 Rules: Settings Integration ချိတ်ဆက်ခြင်း

### Rule 8.1: Environment Injection
- `CountryViewModel` ကို `HolidayCalendarApp` level မှာ `@State` နဲ့ create လုပ်ရမယ်
- `.environment(countryViewModel)` နဲ့ inject လုပ်ရမယ်

### Rule 8.2: App Entry Point Update
```swift
@main
struct HolidayCalendarApp: App {
    @State private var countryViewModel = CountryViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(countryViewModel)
        }
    }
}
```

### Rule 8.3: Settings → Countries Navigation
- Settings view ထဲမှာ `NavigationLink` နဲ့ `CountrySelectionView` ကို link လုပ်ရမယ်
- Deep nested navigation မလုပ်ရ

### Rule 8.4: ViewModel Sharing
- CountrySelectionView ကရော CalendarView ကရော same ViewModel instance ကို access လုပ်ရမယ်
- Separate instances မဖန်တီးရ

### Rule 8.5: Build and Run Test
- ဒီ step ပြီးရင် app ကို simulator မှာ run ပြီး အောက်ပါ tests pass ရရမယ်:
  1. App launch → TabView ၄ tab ပေါ်ရမယ်
  2. Calendar tab default selected ဖြစ်ရမယ်
  3. Settings → Countries → Country list ပေါ်ရမယ်
  4. Initial state: JP ✅, MM ✅, AU ❌, KR ❌, TH ✅
  5. Toggle ပြောင်းရင် ချက်ချင်း update ဖြစ်ရမယ်
  6. App kill → relaunch → state persist ဖြစ်ရမယ်

### Rule 8.6: Git Commit
```
git add -A && git commit -m "feat: integrate CountryViewModel as environment object and connect Settings"
```

---

## Country System Critical Rules (Country System အရေးကြီး စည်းမျဉ်းများ)

### Rule C1: No Hard-coded Calendar Logic
- Country selection logic ကို calendar ထဲမှာ hard-code မလုပ်ရ
- Calendar က `selectedCountryCodes` ကို filter အနေနဲ့ သုံးရမယ်

### Rule C2: Collection-based Selection
- Selected countries ကို `Set<String>` (country codes) နဲ့ manage လုပ်ရမယ်
- Separate boolean properties (isJapanSelected, etc.) မဖန်တီးရ

### Rule C3: Scalability
- နိုင်ငံ ၆, ၇, ၁၀ ခု ထပ်ထည့်ရင် UI logic ပြန်ရေးစရာ မလိုရအောင် design လုပ်ရမယ်
- Country array ထဲ data ထပ်ထည့်လိုက်ယုံနဲ့ အလုပ်လုပ်ရမယ်

### Rule C4: No Separate Calendar Implementations
- နိုင်ငံ ၅ ခုအတွက် calendar implementation ၅ ခု သီးခြားမဖန်တီးရ
- Calendar implementation တစ်ခုတည်း — country filter နဲ့ ရွေးပြတာ

### Rule C5: Reactive Updates
- Country selection ပြောင်းရင် calendar filtering ချက်ချင်း react ဖြစ်ရမယ်
- Manual refresh button မလို

### Rule C6: Country Code Stability
- Country code (JP, MM, AU, KR, TH) ကို stable identifier အနေနဲ့ သုံးရမယ်
- Code ပြောင်းမရ — app lifetime throughout

---

## Platform Rules

### Rule P1: iOS Target
- Minimum deployment target: iOS 17.0
- `@Observable` macro support required

### Rule P2: No Cross-platform
- Native iOS only — Flutter/React Native/KMP မသုံးရ

### Rule P3: Xcode Build
- Step တစ်ခုစီပြီးတိုင်း Xcode build success ဖြစ်ရမယ်
- Build error ရှိရင် ရပ်ပြီး fix လုပ်ရမယ်

---

## Phase Boundary Rules (Phase ကူးခြင်း စည်းမျဉ်းများ)

### Rule PB1: Phase 1 & 2 Scope
- Phase 1: Project setup, TabView, placeholder screens
- Phase 2: Country model, ViewModel, SelectionView, persistence
- ဒီ ၂ phase ကိုသာ implement လုပ်ရမယ်

### Rule PB2: Do NOT Build Yet
- ❌ Backend (Laravel)
- ❌ Holiday API
- ❌ Authentication
- ❌ AWS
- ❌ Calendar implementation (Phase 3 မှ)
- ❌ Todo CRUD (Phase 5 မှ)
- ❌ Memo CRUD (Phase 6 မှ)

### Rule PB3: After Phase 1 & 2
- ဖန်တီးထားတဲ့ files အားလုံးကို ရှင်းပြရမယ်
- Data flow ကို ရှင်းပြရမယ်
- Country selection ဘယ်လို အလုပ်လုပ်တယ် ရှင်းပြရမယ်
- Persistence ဘယ်လို အလုပ်လုပ်တယ် ရှင်းပြရမယ်
- Xcode မှာ run နည်း ပြောပြရမယ်
- Test လုပ်ရမယ့် items ပြောပြရမယ်
- ပြီးရင် STOP
