// ==UserScript==
// @name         Perfume Info Display with Clickable Image
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  Display perfume info with a clickable image that opens the URL in a new tab
// @author       You
// @match        https://lista.mercadolivre.com.br/_CustId_176774316
// @match https://armi5338416.mercadoshops.com.br/
// @match https://armi5338416.mercadoshops.com.br/lista/beleza-cuidado-pessoal/perfumes/
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    // String of image filenames, separated by line breaks
    const imageFilenamesString = `
212se.png
420.jpg
420.png
69297636.jpg
adaptador.png
alok-standard-scale-2_00x.jpg
alok.jpg
amor.png
amour.png
android-icon-144x144.png
android-icon-192x192.png
android-icon-36x36.png
android-icon-48x48.png
android-icon-72x72-gigapixel-standard-scale-4_00x.jpg
android-icon-72x72.png
android-icon-96x96-gigapixel-standard-scale-4_00x.jpg
android-icon-96x96.png
animale (1).jpg
animale.jpg
animale.png
animalekit.png
antonioBandera (1).png
antonioBandera.png
antoniosilver (1).jpg
antoniosilver-standard-scale-2_00x.jpg
AntonioSilver.jpg
antoniosilver.jpg
apple-icon-114x114.png
apple-icon-120x120.png
apple-icon-144x144-gigapixel-standard-scale-4_00x.jpg
apple-icon-144x144.png
apple-icon-152x152.png
apple-icon-180x180.png
apple-icon-57x57.png
apple-icon-60x60.png
apple-icon-72x72.png
apple-icon-76x76.png
apple-icon-precomposed-gigapixel-standard-scale-4_00x.jpg
apple-icon-precomposed.png
apple-icon.png
aviador.jpg
aviador2.png
aviadorroxo-standard-scale-2_00x (1).jpg
aviadorroxo-standard-scale-2_00x.jpg
aviadorroxo.jpg
aviadorroxo.webp
azzaro-standard-scale-2_00x.jpg
azzaro.jpg
azzaro.png
azzarosport.png
banner1.png
barbecue-standard-scale-2_00x.jpg
barbecue.jpg
barbecue.png
barbeiro (1).png
barbeiro-standard-scale-2_00x.jpg
barbeiro.png
bb-standard-scale-2_00x.jpg
bb.png
bg.png
billion.png
billion2.png
blue-standard-scale-2_00x.jpg
blue.jpg
blue.png
bluedeo-standard-scale-2_00x.jpg
bluedeo.jpg
bluef (1).jpg
bluef.jpg
bluef.png
bluefeminino-standard-scale-2_00x.jpg
bluefeminino.jpg
bluemodel-standard-scale-2_00x-gigapixel.jpg
blueseduction (1)-standard-scale-2_00x.jpg
blueseduction (1).png
blueseduction.jpg
blueseduction.png
bogart.jpg
bogart.png
botica.png
britney.jpg
britney.png
bulgari-standard-scale-2_00x.jpg
bulgari.jpeg
bulgari.jpg
bulgari.png
calvin.jpg
calvin.png
camaro-standard-scale-2_00x.jpg
camaro.jpg
camaro.png
camarored.png
capa.png
cart.png
casino.jpeg
charger.png
churras.jpg
classico.jpg
classico2.png
classicofem.jpg
club.jpg
club.png
clube420.png
coeur.jpg
coeur.png
coffee.png
colonia.png
color.png
cool.png
deo.png
deodorant.jpg
doorbell.png
eggeo.png
elysee.png
emagreca.jpg
emagreça.jpg
emagreça.png
euphoria.jpeg
euphoria.jpg
everlast.jpg
everlast.png
extensor.png
fairy.png
favicon-16x16.png
favicon-32x32.png
favicon-96x96.png
favicon.png
feminino.jpg
ferrari.png
ferrarired.png
fit-1024x436.png
flame.png
florata.png
forum.png
fundo.jpg
gabriela.jpg
gabriela.png
gold.png
goodgirl.png
granada.png
GymHome-e1626300110104.jpg
hergolden-standard-scale-2_00x.jpg
hergolden.jpg
hergolden.png
hergolden2.jpg
HerGolden3-standard-scale-2_00x.jpg
HerGolden3.jpg
hergoldenkit-standard-scale-2_00x (1).jpg
HerGoldenKit-standard-scale-2_00x.jpg
HerGoldenKit.jpeg
hergoldenkit.jpg
hergoldensecret-standard-scale-2_00x.jpg
hergoldensecret.png
hersecret3.png
hertemptation-standard-scale-2_00x (1).jpg
hertemptation.jpeg
hertemptation.jpg
hugo.jpg
hugo.png
hugoBoss.jpg
hugojust.jpg
hugojust.png
icon.png
idole.png
inova.png
insta.jpg
instagram.jpg
instagram.png
instagram2.png
inteligencia.jpg
intercambio.jpg
intercambio.png
jaques.jpeg
jaques.jpg
jogo.png
joop.jpg
joop.png
juliana.jpg
juliana.png
king.png
king3.png
kit2.png
kitnovo.png
kouros.png
kway.jpg
lacoste.jpeg
lacoste.png
lamborgini.png
latest_gallery_5.png
latest_gallery_6.png
latest_gallery_7.png
lavalier.png
lavie.png
lift.jpeg
lili.png
loading.gif
love.png
miarpgross.jpg
midnight.png
miss.jpg
miss.png
mont.jpeg
mont.jpg
montblanc.png
ms-icon-144x144.png
ms-icon-150x150.png
ms-icon-310x310.png
ms-icon-70x70.png
mulher.jpg
mulher.png
next.png
night.png
novo1.png
one.jpeg
one.jpg
one.png
oso.png
pelo.png
petite.jpg
petite.png
petite2.jpg
petite2.png
pintor.jpg
polo.png
power-standard-scale-2_00x (1).jpg
power-standard-scale-2_00x.jpg
power.jpg
power.png
powerboost.png
powerOfSeductionsBrancoBanderas.jpg
powerOfSeductionsBrancoBanderas.png
prev.png
quasar.png
queen.png
recent_post_2.png
recent_post_3.png
roxo.jpeg
roxo.jpg
roxo.png
roxokit.jpg
roxokit.png
sabatini2.png
scent.png
Screenshot_2022-10-07_164529-removebg-preview (1).png
scroll-icon.png
silver.png
silver2.png
silverlight.png
silverlightfem-removebg-preview.png
silverlightfem.png
smart.png
speaker.png
sucesso.jpg
sucesso.png
teste.jpg
think.jpeg
tiktok.jpg
tiktok2.png
torto.jpg
torto_1.jpg
tradicional.png
treine.png
udv.jpg
udv.png
udvblue-standard-scale-2_00x.jpg
udvblue.jpg
udvblue.png
universal.png
urban.jpg
urban.png
vanilla.png
vendas.jpg
vendas.png
vip.jpeg
vip.png
vogue.jpg
water.png
whats-standard-scale-2_00x.jpg
whats.png
whatsapp.png
wild.jpg
wild.png
wild2.png
youngpink.png
youtube.jpg
youtube.png
zaad.png`;

    // Convert the string into an array of filenames
    const imageFilenames = imageFilenamesString.split(/\r?\n/).map(s => s.trim()).filter(Boolean);


    // Function to determine the correct image filename based on the perfume name
    function getImageFileName(perfumeName) {
        let imageFileName = 'placeholder-image.png'; // Default image if no match found
        perfumeName = perfumeName.toLowerCase();
        for (let filename of imageFilenames) {
            if (perfumeName.includes(filename.toLowerCase().replace(/\.(jpg|png|jpeg|gif)$/, ''))) {
                imageFileName = filename;
                break;
            }
        }
        return imageFileName;
    }

    // Function to create and display the popup with the generated HTML
    function createPopup(htmlContent) {
        const popupContainer = document.createElement('div');
        popupContainer.style.position = 'fixed';
        popupContainer.style.top = '50%';
        popupContainer.style.left = '50%';
        popupContainer.style.transform = 'translate(-50%, -50%)';
        popupContainer.style.backgroundColor = 'white';
        popupContainer.style.padding = '20px';
        popupContainer.style.border = '1px solid black';
        popupContainer.style.zIndex = '10000';
        popupContainer.style.maxWidth = '80vw';
        popupContainer.style.maxHeight = '80vh';
        popupContainer.style.overflow = 'auto';

        const textArea = document.createElement('textarea');
        textArea.style.width = '100%';
        textArea.style.height = '400px';
        textArea.value = htmlContent;

        const copyButton = document.createElement('button');
        copyButton.textContent = 'Copy to Clipboard';
        copyButton.style.display = 'block';
        copyButton.style.width = '100%';
        copyButton.style.marginTop = '10px';
        copyButton.onclick = function() {
            textArea.select();
            document.execCommand('copy');
            alert('Content copied to clipboard!');
        };

        popupContainer.appendChild(textArea);
        popupContainer.appendChild(copyButton);

        document.body.appendChild(popupContainer);
    }

    // Function to extract perfume info and generate HTML
    function extractAndGenerateHTML() {
        let htmlContent = '';

        // Selector for Mercado Livre
        let perfumeCards = document.querySelectorAll('.ui-search-layout__item');

        // If Mercado Livre cards are not found, try the selector for the new site structure
        if (!perfumeCards.length) {
            perfumeCards = document.querySelectorAll('.ui-item.items-per-row-5');
        }

        perfumeCards.forEach(card => {
            let perfumeName, imageUrl, perfumeUrl;

            // Extracting for Mercado Livre
            if (card.matches('.ui-search-layout__item')) {
                const titleSection = card.querySelector('section[aria-label]');
                perfumeName = titleSection ? titleSection.getAttribute('aria-label') : 'Unknown Perfume';
                const imageElement = card.querySelector('img.ui-search-result-image__element');
                imageUrl = imageElement ? imageElement.src : 'placeholder-image.png';
                const linkElement = card.querySelector('a.ui-search-link');
                perfumeUrl = linkElement ? linkElement.href : '#';
            }
            // Extracting for the new site structure
            else if (card.matches('.ui-item.items-per-row-5')) {
                const imageElement = card.querySelector('img.ui-item__image');
                perfumeName = imageElement ? imageElement.alt : 'Unknown Perfume';
                imageUrl = imageElement ? imageElement.src : 'placeholder-image.png';
                perfumeUrl = card.href;
            }

            const imageName = getImageFileName(perfumeName);
            htmlContent += `
<div class="border-2 border-gray-200 rounded-lg overflow-hidden shadow-lg hover:shadow-2xl transition-shadow duration-300 ease-in-out mb-4">
    <a href="${perfumeUrl}" target="_blank">
        <img src="${imageUrl}" alt="${perfumeName}" class="w-full h-64 object-cover">
        <div class="p-4">
            <h2 class="font-bold text-lg">${perfumeName}</h2>
        </div>
    </a>
</div>
`;
        });

        if (htmlContent) {
            createPopup(htmlContent);
        } else {
            console.error('No HTML content generated.');
        }
    }

    window.addEventListener('load', extractAndGenerateHTML);
})();
