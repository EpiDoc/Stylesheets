XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
XXX     README.txt for example-p5-xslt              XXX
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

What it is:

	XSLT for transformation of EpiDoc XML files into HTML or text
	versions in Leiden. Includes various XML files containing
	parameters and other options.

	To cite these stylesheets in a conventional bibliography, please
	include the following information:

	Tom Elliott, Zaneta Au, Gabriel Bodard, Hugh Cayless,
	Carmen Lanz, Faith Lawrence, Scott Vandebilt, Raffaele
	Viglianti, et al. (2008-2013), EpiDoc Example Stylesheets
	(version 8). Available:
	<https://sourceforge.net/p/epidoc/wiki/Stylesheets/>

License:

	These scripts are copyright Zaneta Au, Gabriel Bodard and
	all other contributors.
	See LICENSE.txt for license details.

Technical requirements:

	These scripts are written in XSLT 2.0 and may be transformed
	using any conformant XSLT processor.
	(Tested with Saxon-HE 9.4.0.6.)

How to obtain the stylesheets:

	Two methods:

	(1) check out from the EpiDoc Subversion repository. On a Mac
	or Linux machine with Subversion installed, simply create a directory
	into which you want to check out the xslt, and then on the
	command-line enter:

	svn checkout https://epidoc.svn.sourceforge.net/svnroot/epidoc/trunk/example-p5-xslt your_directory

	On Windows, or using a client such as TortoiseSVN or Oxygen's
	SynchroSVN, check out the repo from
	https://epidoc.svn.sourceforge.net/svnroot/epidoc/trunk/example-p5-xslt
	to your local repository.

	(2) download the latest packaged, stable release from the SourceForge
	repository at https://sourceforge.net/projects/epidoc/files/epidoc-xsl/

How to use it:

	XSLT may be run on an individual EpiDoc XML file, creating a
	single file output (e.g. via a command-line Saxon call or an
	Oxygen transformation scenario) or batch-run upon a large
	collection of files via some other process (e.g. an Oxygen project,
	set of batch files, etc.). Call the start-edition.xsl stylesheet to create
	a HTML version of the output (this xsl calls both generic and
	specialized files needed), or start-txt.xsl to create a text-only
	version of the text output.

	Transformations are parameterised so that they may be used by
	different projects with only a change in local parameters, the scripts
	themselves being identical for all users. Change the parameters
	either by (a) changing the global-parameters.xml in your local copy
	(please do *not* commit these changes to SVN), or (b) setting local
	variables in your Saxon command-line, Oxygen scenario, etc.

	The parameters currently defined include:

	$internal-app-style:
		Generate a paragraph of apparatus immediately below
		the text unless value is "none" (default); via equivalent of
		TEI "Parallel Segmentation" apparatus encoding.
		Values defined include: 'ddbdp' (generate very rich
		apparatus from tei:app, tei:subst, tei:choice, tei:hi etc.
		elements in the text); 'iospe' (generate simple apparatus
		from tei:choice and children in text only).
	$external-app-style:
		Variant ways to interpret the markup in `div[@type='apparatus']`,
		assumed to follow equivalent of TEI "Location-Referenced"
		apparatus encoding. The only specialized value defined is 'iospe',
		which processes bibliography richly.
	$css-loc
		Default value is '../xsl/global.css'. Path of CSS file referenced in
		the resulting HTML file.
	$docroot
		Default value is '../output/data'
	$edition-type:
		values are 'interpretive' (default) and 'diplomatic' (prints edition
		in uppercase, no restored, corrected, expanded characters, etc.)
	$edn-structure
		implemented values are 'default' (no metadata), 'inslib', 'iospe'
	$hgv-gloss
		value is '../../../xml/idp.data/trunk/HGV_trans_EpiDoc/glossary.xml'.
		Location of HGV glossary file relative to the current file.
		Used by Papyrological Navigator only.
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