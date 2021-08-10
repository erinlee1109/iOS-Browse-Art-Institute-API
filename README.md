# Browse Art in Art Institute of Chicago

## _#Decolonize This Place_
## Intro/Goal
**I am tired of using art education apps filled with recommendations to browse works by male European artists. I started developing an iOS mobile app where users will be guided to primarily engage with art/artists from underrepresented communities using Art Institute's wonderful API.** 👩🏻‍💻 

### Language / Tools
* Swift / Xcode
* [CocoaPods](https://cocoapods.org/) / [AlarmofireImage](https://cocoapods.org/pods/Alamofire)

### API
* [Art Institute of Chicago's Public API](https://api.artic.edu/docs)
* [IIIF API (Images)](https://api.artic.edu/docs/#iiif-image-api)

### Wireframe
<img src=figma-blueprint.png width=700>

---

### To Be Implemented (High Priority)
- [ ] User can click the artist's name in the details screen to see other works by the same artist. 
- [ ] Make details screen's info section scrollable (upward). Add "read more" button to read description of the artwork.  

### To Be Implemented (Lower Priority, a.k.a soon-to-be high priority)
- [ ] "Recommended for you" cards with featured artist and artworks from underrepresented communities.
- [ ] Implement pull to refresh, to load data when a devices come back online or to fetch new data. 
- [ ] Implement 'confirm' search function where user can hide the keyboard and continue browsing the searched result.
- [ ] Notify the user when the device is offline.
- [ ] Have ~10 artworks available offline. 
- [ ] User can download image. 

---

### Current User Stories (Jul 23 Update)

- [x] **Left GIF** User will see a Lottie animation while API data is being fetched. The animation disappears as soon as art information is ready to be displayed. 
- [x] **Right GIF** Restructured the appearance of the detail screen. 

<img src="https://recordit.co/V5Txb2s46t.gif" width=200> <img src="https://recordit.co/A30z2sdq9D.gif" width=200>

### May 10 Update

**Left GIF**

- [x] User can scroll through artworks to skim titles, artists, dates, and image. 
- [x] User can tab into any cell to view larger image, title, artist, and date information. 

**Right GIF**

- [x] User can search for any combination of English alphabet and numbers. The search bar successfully only accepts English alphabet and numbers. Other languages will not be accepted as an input, will not be passed as an invalid URL, and will not crash the app. 
- [x] While input text remains in the search bar, user can scroll through the search results. The search bar stays on top of the screen without disappearing. 

<img src="https://recordit.co/MqmKkoaMC9.gif" width=200> <img src="https://recordit.co/5YNJ1EPOuM.gif" width=200>

### To Be Implemented (higher priority) 

- [ ] Make images fill up the entire square in the main view controller. (Should it though? This is a design choice.) 
- [x] **[Implemented Jul 22]** Make images fill up the entire UI Image View in the details screen.
- [x] **[Postponed Jul 22]** Connect to Twitter and allow the user to retweet an artwork.

### Bonus Items that can be implemented (lower priority) 

- [ ] Implement 'confirm' search function where user can hide the keyboard and continue browsing the searched result.
- [x] **[Solved Jul 22]** User can click on the image in the detail screen and view the full image. 
- [ ] User can download image. 

---

### May 9 Update  

- [x] User can search using the search bar. 

**To Be Implemented**

- [x] **[Impleneted May 10]** URL needs to be verified after concatenation. Currently, the app crashes when user searches produce invalid API link.

<img src="https://recordit.co/Un8wplnnpd.gif" width=150><br>

---

### May 4 Update 

- [x] User can scroll through artworks to skim titles, artists, and dates. 

**To Be Implemented**

- [x] **[Implemented May 10]** Yet to retrieve images using the IIIF API.
- [x] **[Implemented May 10]** Yet to implement the detail view screen.
- [x] **[Implemented May 10]** Yet to implement a search bar.

<img src="https://recordit.co/uDXXe7EXCO.gif" width=150><br>
