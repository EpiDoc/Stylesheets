XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
XXX     README.txt for example-p5-xslt              XXX
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

What it is:

	XSLT for transformation of EpiDoc XML files into HTML or text
	versions in Leiden. Includes various XML files containing parameters
	and other options.

License:

	These scripts are copyright Zaneta Au, Gabriel Bodard and all other contributors.
	See LICENSE.txt for license details.

Technical requirements:

	These scripts are written in XSLT 2.0 and may be transformed using any
	conformant XSLT processor. (Tested with Saxon-HE™ 9.2.0.6.)

How to use it:

	XSLT may be run on an individual EpiDoc XML file, creating a single file output
	(e.g. via a command-line Saxon™ call or an Oxygen™ transformation scenario)
	or batch-run upon a large collection of files via some other process (e.g. an
	Oxygen™ project, set of batch files, etc.). Call the start-edition.xsl stylesheet to create
	a HTML version of the output (this xsl calls both generic and specialized files needed),
	or start-txt.xsl to create a text-only version of the text output.

	Transformations are parameterised so that they may be used by different projects
	with only a change in local parameters, the scripts themselves being identical
	for all users. Change the parameters either by (a) changing the global-parameters.xml
	in your local copy (please do *not* commit these changes to SVN), or (b) setting local
	variables in your Saxon command-line, Oxygen scenario, etc.

	The parameters currently defined include:

	$apparatus-style:
		values are 'default' (generate apparatus from tei:div[@type='apparatus'])
		and 'ddbdp' (generate apparatus from tei:app, tei:subst, tei:choice,
		tei:hi etc. elements in the text.
	$css-loc
		value is '../xsl/global.css'. Path of CSS file referenced in
		the resulting HTML file.
	$docroot
		value is '../output/data'
	$edition-type:
		values are 'interpretive' (default) and 'diplomatic' (prints edition
		in uppercase, no restored, corrected, expanded characters, etc.)
	$edn-structure
		values are 'default', 'ddbdp', 'hgv', 'london', 'petrae-en',
		'petrae-fr', 'petrae-ru', and 'sammelbuch'
	$hgv-gloss
		value is '../../../xml/idp.data/trunk/HGV_trans_EpiDoc/glossary.xml'.
		Location of HGV glossary file relative to the current file.
	$leiden-style:
		values include 'panciera' (default), 'ddbdp', 'dohnicht',
		'edh-web' (and 'edh-itx', 'edh-names'), 'ila', 'london',
		'petrae', 'rib', 'seg', and 'sammelbuch'. These change minor
		variations in local Leiden usage; brackets for corrected text,
		display of previously read text, illegible characters, etc.
	$line-inc:
		default value = 5, may be locally defined to any integer value
	$topNav
		values are 'default' and 'ddbdp'
	$verse-lines:
		values are 'off' (default), and 'on' (when a text of section of
		text is tagged using <lg> and <l> elements [instead of <ab>] then
		edition is formatted and numbered in verse lines rather than
		epigraphic lines)

