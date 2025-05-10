'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "db0c8217599784bef0937f16ca0e8b77",
"assets/AssetManifest.bin.json": "54fd076de28e762306aac0eed2cf2b28",
"assets/AssetManifest.json": "5595158279f2cc3bd49ab67a7664dcea",
"assets/assets/weddingassets/bg_flower.png": "78f9e2b47ee32111f885be1db88f88a4",
"assets/assets/weddingassets/bismillah.png": "a473c8f944749f09242c4b2d6f2812de",
"assets/assets/weddingassets/feather_bottom.png": "4a52fb655bbd7540eced20d420259115",
"assets/assets/weddingassets/feather_top.png": "43215c2d01338d9bccecf9fbcd9b0302",
"assets/assets/weddingassets/flower_bottomleft.png": "2667d6b205d1d7ea5198391bf20884e9",
"assets/assets/weddingassets/flower_topright.png": "0ddd50667f4c0ce5f3e50f65a19d8041",
"assets/assets/weddingassets/outline_leaf_gold.png": "399e2b515d1376d5876aa75df9f66920",
"assets/assets/weddingassets/splash_gold_bottomleft.png": "d828ff6430d2dbb476e9b1c39dcf5915",
"assets/assets/weddingassets/splash_gold_bottomright.png": "548143a26fedca60b9b1f7174499ab53",
"assets/assets/weddingassets/splash_gold_middleright.png": "db730c1894b3c34305e305b62929b4c0",
"assets/assets/weddingassets/splash_gold_topleft.png": "bbae30ef20103424901d95b5d1683a3d",
"assets/assets%255Cweddingassets%255Cbg_flower.png": "78f9e2b47ee32111f885be1db88f88a4",
"assets/assets%255Cweddingassets%255Cbismillah.png": "a473c8f944749f09242c4b2d6f2812de",
"assets/assets%255Cweddingassets%255Cfeather_bottom.png": "4a52fb655bbd7540eced20d420259115",
"assets/assets%255Cweddingassets%255Cfeather_top.png": "43215c2d01338d9bccecf9fbcd9b0302",
"assets/assets%255Cweddingassets%255Cflower_bottomleft.png": "2667d6b205d1d7ea5198391bf20884e9",
"assets/assets%255Cweddingassets%255Cflower_topright.png": "0ddd50667f4c0ce5f3e50f65a19d8041",
"assets/assets%255Cweddingassets%255Coutline_leaf_gold.png": "399e2b515d1376d5876aa75df9f66920",
"assets/assets%255Cweddingassets%255Csplash_gold_bottomleft.png": "d828ff6430d2dbb476e9b1c39dcf5915",
"assets/assets%255Cweddingassets%255Csplash_gold_bottomright.png": "548143a26fedca60b9b1f7174499ab53",
"assets/assets%255Cweddingassets%255Csplash_gold_middleright.png": "db730c1894b3c34305e305b62929b4c0",
"assets/assets%255Cweddingassets%255Csplash_gold_topleft.png": "bbae30ef20103424901d95b5d1683a3d",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "42aad10142f23d1ee6d7ff350883772f",
"assets/NOTICES": "23761f1acdede8160865d5e18065c193",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "b4128e8f415039c76ed90418b43fd321",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "5b16af525f736773ff29ddcd3bde8013",
"/": "5b16af525f736773ff29ddcd3bde8013",
"main.dart.js": "586d00aa22287c438df07ae7493bb102",
"manifest.json": "875f43765f755556c12296847c3f6003",
"vercel.json": "85a935fb1851f9ece04369a85ae2cfb6",
"version.json": "3c6ab019ac8942cf1572e2bf774b2d53"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
