import glob
import os.path
import shlex
import subprocess
import unittest


class HTMLFullOutputTestCase(unittest.TestCase):

    """Tests that the full HTML output for each available edition
    structure is as expected.

    The comparison between actual and expected results is a straight
    string comparison; no XML c14n is performed.

    """

    _command = 'java net.sf.saxon.Transform -s:{source} -xsl:{xsl} ' \
               '-versionmsg:off edn-structure={structure}'
    _structures = ('default', 'inslib', 'iospe')

    def setUp(self):
        base_dir = os.path.dirname(os.path.abspath(__file__))
        data_dir = os.path.join(base_dir, 'data')
        xslt_dir = os.path.dirname(base_dir)
        self._expected_dir = os.path.join(data_dir, 'expected', 'full_html')
        self._html_xslt = os.path.join(xslt_dir, 'start-edition.xsl')
        self._source_files = os.path.join(data_dir, 'source', '*.xml')

    def _check_output(self, args):
        """Asserts that the output of transformation with `args` matches the
        contents of the file corresponding to the source file
        specified in `args`."""
        actual = subprocess.check_output(shlex.split(self._command.format(
            **args)))
        expected = self._get_expected(args['structure'], args['source'])
        self.assertEqual(actual.decode('utf-8'), expected)

    def _get_expected(self, structure, source):
        """Returns the string contents of the expected file corresponding to
        `structure` and `source`."""
        expected = os.path.splitext(os.path.basename(source))[0] + '-' + \
                   structure + '.html'
        full_expected = os.path.join(self._expected_dir, expected)
        with open(full_expected, 'r', encoding='utf-8') as fh:
            contents = fh.read()
        return contents

    def test_edition_structure(self):
        """Test full HTML output with various edition structures."""
        for source in glob.glob(self._source_files):
            for structure in self._structures:
                with self.subTest(source=source, structure=structure):
                    args = {'source': source, 'structure': structure,
                            'xsl': self._html_xslt}
                    self._check_output(args)


if __name__ == '__main__':
    unittest.main()
