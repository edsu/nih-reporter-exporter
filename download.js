import { chromium, devices } from 'playwright';


async function main() {
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext(devices['Desktop Chrome']);
  const page = await context.newPage();

  await page.goto('https://reporter.nih.gov/exporter/');
  await download(page, 'Abstracts');
  await download(page, 'Publications');
  await download(page, 'Patents');
  await download(page, 'Clinical Studies');
  await download(page, 'Link Tables');
  await download(page, 'Projects');

  await browser.close();
}

const sleep = ms => new Promise(r => setTimeout(r, ms));

async function download(page, linkText) {
  console.log(`downloading ${linkText}`);
  await page.getByRole('link', {name: linkText}).click();

  // this sleep is needed to ensure that the REST call that is initiated by the
  // click returns, and the DOM changes render. 🤷
  await sleep(5000);

  // get each dataset row from the table
  for (const row of await page.locator('tbody tr').all()) {
    const datasetName = await row.locator('td').first().textContent();
    process.stdout.write(`${datasetName} --> `);

    // click the download button and wait for it to be done
    const downloadPromise = page.waitForEvent('download');
    const downloadIcon = await row.locator('.fa-cloud-download-alt').first();
    await downloadIcon.click();
    const download = await downloadPromise;

    // persist the download
    const filename = `data/${download.suggestedFilename()}`;
    await download.saveAs(filename);
    console.log(filename);
  }
}

main();
