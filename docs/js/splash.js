const parser = new DOMParser();

async function fetchSVG(svg_name, div_target) {
    const response = await fetch(svg_name);
    const svgText = await response.text();
    const svgDoc = parser.parseFromString(svgText, 'text/xml');
    div_target.appendChild(svgDoc.documentElement);
}

window.onload = function () {

    window.location.replace("html/about-this-exercise.html");

}
