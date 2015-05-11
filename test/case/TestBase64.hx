
import om.util.Base64;

class TestBase64 extends haxe.unit.TestCase {

	public function test_encode() {

		// Encode

		assertEquals( 'YW55IGNhcm5hbCBwbGVhc3VyZS4=', Base64.encode('any carnal pleasure.') );
		assertEquals( 'YW55IGNhcm5hbCBwbGVhc3VyZQ==', Base64.encode('any carnal pleasure') );
		assertEquals( 'YW55IGNhcm5hbCBwbGVhc3Vy', Base64.encode('any carnal pleasur') );
		assertEquals( 'YW55IGNhcm5hbCBwbGVhc3U=', Base64.encode('any carnal pleasu') );
		assertEquals( 'YW55IGNhcm5hbCBwbGVhcw==', Base64.encode('any carnal pleas') );
		
		// Padding
		//assertEquals( 'YW55IGNhcm5hbCBwbGVhc3VyZS4=', Base64.pad('YW55IGNhcm5hbCBwbGVhc3VyZS4') );

	}

}
