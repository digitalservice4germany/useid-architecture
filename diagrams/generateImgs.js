const { execSync } = require("child_process");
const axios = require("axios");
const { chromium } = require("playwright");
const workspacePage = "http://localhost:8080/workspace/diagrams/";

function run(cmd) {
  execSync(cmd, function (err, stdout, stderr) {
    console.log(stdout);
    console.error(stderr);
    if (err) {
      console.error(err);
    }
  });
}

async function startContainer(flowName) {
  run(
    'docker pull structurizr/lite && docker run --name structurizr -d --rm -p 8080:8080 -v "$(pwd):/usr/local/structurizr" -e STRUCTURIZR_WORKSPACE_FILENAME=workspace-' + flowName + ' structurizr/lite'
  );

  // wait for container to become available
  const sleepInterval = 500; //ms
  let start = Date.now();
  while (true) {
    if (Date.now() - start > 60000) {
      throw new Error("container did not become available after 60s");
    }

    try {
      await axios(workspacePage);
      break;
    } catch {
      await new Promise((resolve) => setTimeout(resolve, sleepInterval));
    }
  }
}

function stopContainer() {
  run("docker kill structurizr");
}

async function downloadImgs(flowName) {
  const browser = await chromium.launch({ headless: true });
  const page = await browser.newPage();
  await page.goto(workspacePage);

  // accept terms - only on first run, so we allow this to fail
  try {
    await page.click('text=Accept', { timeout: 5000 });
  } catch {
    // ok, probably already accepted
  }

  // allow workspace to load fully
  await page.waitForLoadState("networkidle");

  await page.click('text=× Diagram editor >> [aria-label="Close"]');
  await page.click('[title="Export diagram and key/legend to PNG"]');
  await page.check("text=Crop diagrams");
  await page.check("text=Automatically download");

  page.on("download", async (download) => {
    await download.saveAs("./imgs/" + flowName + "/" + download.suggestedFilename());
    await download.delete();
  });

  await page.click("text=Export all diagrams");

  // allow all downloads to complete
  await page.waitForLoadState("networkidle");

  // wait for the download and delete the temporary file
  await browser.close();
}

async function generateImages(flowName) {
  try {
    await startContainer(flowName);
    await downloadImgs(flowName);
  } catch(error) {
    console.error(error)
    process.exit(1)
  } finally {
    await stopContainer();
  }
}

(async () => {
  await generateImages("paula")
  await generateImages("magnus")
})();
