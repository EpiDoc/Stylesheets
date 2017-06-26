import glob
import os.path
import shlex
import subprocess
import tempfile
import unittest


class HTMLFullOutputTestCase(unittest.TestCase):

    """Tests that the full HTML output for each available edition
    structure is as expected.

    The comparison between actual and expected results is a straight
    string comparison; no XML c14n is performed.

    """

    _command = 'java net.sf.saxon.Transform -o:{output} -s:{source} ' \
               '-xsl:{xsl} -versionmsg:off edn-structure={structure}'
    _structures = ('default', 'dol', 'edak', 'inslib', 'iospe', 'spes')

    def setUp(self):
        base_dir = os.path.dirname(os.path.abspath(__file__))
        data_dir = os.path.join(base_dir, 'data')
        xslt_dir = os.path.dirname(base_dir)
        self._expected_dir = os.path.join(data_dir, 'expected', 'full_html')
        self._html_xslt = os.path.join(xslt_dir, 'start-edition.xsl')
        self._source_dir = os.path.join(data_dir, 'source')
        self._source_files = os.path.join(self._source_dir, '*.xml')

    def _get_contents(self, path):
        """Return the contents of `path`."""
        with open(path, 'r', encoding='utf-8') as fh:
            contents = fh.read()
        return contents

    def test_edition_structure(self):
        """Test full HTML output with various edition structures."""
        for structure in self._structures:
            with tempfile.TemporaryDirectory() as actual_dir:
                args = {'output': actual_dir, 'source': self._source_dir,
                        'structure': structure, 'xsl': self._html_xslt}
                subprocess.run(shlex.split(self._command.format(**args)),
                               check=True)
                for source in glob.glob(self._source_files):
                    self._test_edition_structure(source, structure, actual_dir)

    def _test_edition_structure(self, source, structure, actual_dir):
        with self.subTest(source=source, structure=structure):
            base_filename = os.path.basename(source)
            expected_path = os.path.join(
                self._expected_dir, '{}-{}.html'.format(os.path.splitext(
                    base_filename)[0], structure))
            expected = self._get_contents(expected_path)
            actual_path = os.path.join(actual_dir, base_filename)
            actual = self._get_contents(actual_path)
            self.assertEqual(actual, expected)


if __name__ == '__main__':
    unittest.main()
