
import 'package:flutter_test/flutter_test.dart';
import 'package:rpl_keamanan/utils/validators.dart';

void main() {
  group('Pengujian Validators', () {

    // Pengujian email

    group('isValidEmail', () {
      test('Email yang benar harus valid', () {
        expect(
          Validators.isValidEmail('tania@gmail.com'),
          true,
        );
      });

      test('Email tanpa @ harus tidak valid', () {
        expect(
          Validators.isValidEmail('taniagmail.com'),
          false,
        );
      });

      test('Email tanpa domain harus tidak valid', () {
        expect(
          Validators.isValidEmail('tania@'),
          false,
        );
      });
    });

    // Pengujian sanitize

    group('sanitize', () {
      test('Karakter HTML harus diubah', () {
        final result = Validators.sanitize(
          '<script>alert("test")</script>',
        );

        expect(
          result,
          '&lt;script&gt;alert(&quot;test&quot;)&lt;/script&gt;',
        );
      });

      test('Ampersand harus diubah', () {
        expect(
          Validators.sanitize('Tania & teman'),
          'Tania &amp; teman',
        );
      });
    });

    // Pengujian validateText

    group('validateText', () {
      test('Teks kosong harus menghasilkan error', () {
        expect(
          Validators.validateText(''),
          isNotNull,
        );
      });

      test('Teks dengan panjang sesuai harus valid', () {
        expect(
          Validators.validateText(
            'Katharina',
            minLength: 3,
            maxLength: 20,
          ),
          isNull,
        );
      });

      test('Teks terlalu pendek harus error', () {
        expect(
          Validators.validateText(
            'AB',
            minLength: 3,
            maxLength: 20,
          ),
          isNotNull,
        );
      });
    });

    // Pengujian nomor telepon

    group('validatePhone', () {
      test('Nomor telepon valid', () {
        expect(
          Validators.validatePhone('081234567890'),
          isNull,
        );
      });

      test('Nomor telepon mengandung huruf', () {
        expect(
          Validators.validatePhone('08123abc890'),
          isNotNull,
        );
      });

      test('Nomor telepon terlalu pendek', () {
        expect(
          Validators.validatePhone('08123'),
          isNotNull,
        );
      });
    });

    // Pengujian URL

    group('validateUrl', () {
      test('URL HTTPS valid', () {
        expect(
          Validators.validateUrl('https://example.com'),
          isNull,
        );
      });

      test('URL tanpa protokol tidak valid', () {
        expect(
          Validators.validateUrl('example.com'),
          isNotNull,
        );
      });
    });

    // Pengujian password

    group('validatePassword', () {
      test('Password yang memenuhi syarat valid', () {
        expect(
          Validators.validatePassword('Tania123!'),
          isNull,
        );
      });

      test('Password kurang dari 8 karakter', () {
        expect(
          Validators.validatePassword('Ta123!'),
          isNotNull,
        );
      });

      test('Password tanpa huruf kapital tidak valid', () {
        expect(
          Validators.validatePassword('tania123!'),
          isNotNull,
        );
      });

      test('Password tanpa angka tidak valid', () {
        expect(
          Validators.validatePassword('Taniaabcd!'),
          isNotNull,
        );
      });

      test('Password tanpa simbol tidak valid', () {
        expect(
          Validators.validatePassword('Tania1234'),
          isNotNull,
        );
      });
    });
  });
}
