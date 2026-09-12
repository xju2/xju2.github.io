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
5. deploys that artifact through the `github-pages` environment.

A failed build or smoke check prevents deployment. Deployments are serialized,
and an in-progress production deployment is never cancelled by a newer push.

## Publishing configuration

The repository uses **GitHub Actions** as its Pages publishing source. The
custom domain `www.ml4phys.com` is configured in **Settings → Pages**.

For custom Actions workflows, the Pages setting is authoritative and GitHub
ignores the repository's `CNAME` file. The file is retained and smoke-tested
as a repository invariant and to support branch-based rollback; changing it
alone does not change the active custom domain.

No DNS change was required for the deployment migration. DNS must continue to
point `www.ml4phys.com` directly to `xju2.github.io`, with the apex domain
using GitHub Pages A/AAAA or ALIAS/ANAME records.

## Verification

After a production deployment:

1. confirm **Actions → Deploy site** completed successfully;
2. confirm its environment URL is `https://www.ml4phys.com/`;
3. verify the home, projects, publications, talks, and students routes;
4. check **Settings → Pages** for successful custom-domain and HTTPS status.

GitHub's DNS and certificate checks can lag behind a publishing-source change.
If the site and workflow are healthy but Pages temporarily reports
`NotServedByPagesError`, verify the DNS records and allow up to 24 hours for
validation before removing and re-adding the custom domain.

## Rollback

To restore GitHub's branch-based build:

1. Open **Settings → Pages**.
2. Set **Source** to **Deploy from a branch**.
3. Select `master` and `/(root)`, then save.
4. Revert the deployment-workflow pull request if the explicit workflow should
   no longer run.

Because both methods build the same `master` content and retain the existing
`CNAME`, rollback does not require DNS changes.
