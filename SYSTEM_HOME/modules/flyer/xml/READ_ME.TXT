# file:  READ_ME.TXT

This directory contains configuration files for the Rapid Prototype Flyer Processor (RPFP).
Files in this directory can be categorized by the following:
1.  Schema Files     [ .xsd.xml            ]
    A file describing the raw file format.
2.  Raw Files        [ .raw.xml            ]
    The format of the database in raw form.  Used to create seed files.
3.  Seed Files       [ .seed.xml           ]
    Unformatted subreport templates, used when creating new template files.
4.  Template Files   [ .wml-template.xml   ]
    These is the file that you edit for designing reports.
5.  Template Files   [ .wml-style.xml      ]
    Determines the fonts used in the reports.

The flyer consists of three subreports:
1.  flyer-outline.xml-template.xml
    The top level report.
2.  flyer-columns.wml-template.xml
    Subreport that defines a single column on the flyer.
3.  flyer-options.wml-template.xml
    Subreport that defines the options under each class.

# *EOF*