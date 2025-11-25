from pathlib import Path

from cvmgr.mypub import inspire_ids
from cvmgr.writer import PublicationWriter
import click


@click.command("update")
@click.option("-o", "--outdir", help="output directory", default="_publications")
@click.option("-m", "--mode", help="update mode", default="u", type=click.Choice(["a", "u"]))
@click.option(
    "--latex-file",
    help="Optional LaTeX output file for CV entries",
    default="tex_files/generated_publications.tex",
)
@click.option("-w", "--workers", help="number of workers", default=1, type=int)
def main(outdir, mode, workers, latex_file):
    Path(outdir).mkdir(exist_ok=True)

    writer = PublicationWriter(outdir=outdir, mode=mode, latex_file=latex_file)
    record_ids = [str(i) for i in inspire_ids]
    writer.add_all(record_ids)
    writer.write()
    writer.save()
