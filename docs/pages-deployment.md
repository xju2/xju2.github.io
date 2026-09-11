# GitHub Pages deployment

The production site is built and deployed by
`.github/workflows/pages-deploy.yml`. Pull requests continue to run the
validation-only `Site CI` workflow.

## Deployment flow

Every push to `master`, and every manual workflow dispatch:

1. installs the Ruby dependencies pinned by the repository;
2. builds the site with strict front-matter validation;
3. runs the route, asset, custom-domain, and Liquid smoke checks;
4. uploads only the generated `_site` directory as the Pages artifact;
5. deploys that artifact through the protected `github-pages` environment.

A failed build or smoke check prevents deployment. Deployments are serialized,
and an in-progress production deployment is never cancelled by a newer push.

## One-time activation

The repository currently uses GitHub's branch-based Pages build. When this
change is merged, select the Actions publishing source:

1. Open **Settings → Pages** in `xju2/xju2.github.io`.
2. Under **Build and deployment**, set **Source** to **GitHub Actions**.
3. Open **Actions → Deploy site** and run the workflow manually if the merge
   run occurred before the setting was changed.
4. Confirm the deployment reports `https://www.ml4phys.com/` and verify the
   home, projects, publications, talks, and students routes.

No DNS or `CNAME` change is required. The workflow's smoke check requires the
generated artifact to contain `CNAME` with exactly `www.ml4phys.com`.

## Rollback

To restore GitHub's branch-based build:

1. Open **Settings → Pages**.
2. Set **Source** to **Deploy from a branch**.
3. Select `master` and `/(root)`, then save.
4. Revert the deployment-workflow pull request if the explicit workflow should
   no longer run.

Because both methods build the same `master` content and retain the existing
`CNAME`, rollback does not require DNS changes.
