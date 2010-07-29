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

	These scripts are written in XSLT 1.0 and may be transformed using any
	XSLT processor. (Tested with Saxon™ 6.5.5.)

How to use it:

	XSLT may be run on an individual EpiDoc XML file, creating a single file output
	(e.g. via a command-line Saxon™ call or an Oxygen™ transformation scenario)
	or batch-run upon a large collection of files via some other process (e.g. an
	Oxygen™ project, set of batch files, etc.)

	Transformations are parameterised so that they may be used by different projects
	with only a change in local parameters, the scripts themselves being identical
	for all users. The parameters currently defined include:

	$leiden-style:
		values include 'panciera' (default), 'ddbdp', 'london',
		'edh-web' (and 'edh-itx', 'edh-names'). These change minor
		variations in local Leiden usage; brackets for corrected text,
		display of previously read text, illegible characters, etc.
	$meta-style:
		values are 'default' (displays only XML div content in HTML)
		and 'hgv' (extracts metadata from teiHeader and renders as
		expected by the HGV database)
	$verse-lines:
		values are 'off' (default), and 'on' (when a text of section of
		text is tagged using <lg> and <l> elements [instead of <ab>] then
		edition is formatted and numbered in verse lines rather than
		epigraphic lines)
	$edition-type:
		values are 'interpretive' (default) and 'diplomatic' (prints edition
		in uppercase, no restored, corrected, expanded characters, etc.)
	$apparatus-style:
		values are 'default' (generate apparatus from tei:div[@type='apparatus'])
		and 'ddbdp' (generate apparatus from tei:app, tei:subst, tei:choice,
		tei:hi etc. elements in the text.
	$line-increment:
		default value = 5, may be locally defined to any integer value

