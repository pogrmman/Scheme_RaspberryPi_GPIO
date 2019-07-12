;; Copyright 2019 Alexander Mohn
;;
;;    This file is part of the Cyclone Scheme WiringPi Bindings.
;;
;;    The Cyclone Scheme WiringPi Bindings are free software: you can 
;;    redistribute and/or modify them under the terms of the GNU General
;;    Public License as published by the Free Software Foundation, either
;;    version 3 of the License, or (at your option) any later version.
;;
;;    The Cyclone Scheme WiringPi Bindings are distributed in the hope 
;;    that they will be useful, but WITHOUT ANY WARRANTY; without even the
;;    implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
;;    See the GNU General Public License for more details.
;;
;;   You should have received a copy of the GNU General Public License
;;   along with the Cyclone Scheme WiringPi Bindings.  
;;   If not, see <https://www.gnu.org/licenses/>.

(define-library (raspberry-pi gpio spi)
  (import (scheme base))
  (include-c-header "<wiringPiSPI.h>")
  (include "better-c.scm")

  (export setup-spi! make-data-buffer! set-data-buffer! data-buffer-read-write!)

  (begin
    (def-c (setup-spi! "channel" "speed")
      "int succ = wiringPiSPISetup((int) (unbox_number(channel)), 
                                   (int) (unbox_number(speed)));
       if (succ == -1) {
         return_closcall1(data, k, boolean_f);
       }
       return_closcall1(data, k, boolean_t);
      ")

    (def-c (make-data-buffer! "size")
      "unsigned char data_buff_real[(int) (unbox_number(size))];
       make_c_opaque(data_buff, data_buff_real);
       return_closcall1(data, k, &data_buff);
      ")

    (def-c (set-data-buffer! "buffer" "item" "value")
      "unsigned char *buf = (((c_opaque) &buffer)->ptr);
       buf[(int) (unbox_number(item))] = (unsigned char) (unbox_number(item));
       return_closcall1(data, k, buffer);
      ")

    (def-c (data-buffer-read-write! "channel" "buffer" "size")
      "unsigned char *buf = (((c_opaque) &buffer)->ptr);
       int succ = wiringPiSPIDataRW((int) (unbox_number(channel)),
                                    buf,
                                    (int) (unbox_number(size)));
       if (succ == -1) {
         return_closcall1(data, k, boolean_f);
       }
       return_closcall1(data, k, boolean_t);
      ")))
