;; gputils_make_example, Copyright 2013 Vicente Oscar Mier Vela <vomv1988@gmail.com>
;;    This file is part of gputils_make_example.
;;
;;    gputils_make_example is free software: you can redistribute it and/or modify
;;    it under the terms of the GNU General Public License as published by
;;    the Free Software Foundation, either version 3 of the License, or
;;    (at your option) any later version.
;;
;;    gputils_make_example is distributed in the hope that it will be useful,
;;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;    GNU General Public License for more details.
;;
;;    You should have received a copy of the GNU General Public License
;;    along with gputils_make_example.  If not, see <http://www.gnu.org/licenses/>.
	variable	h
h=0
	while	h < 6
S#v(h)	equ	~h
h += 1
	endw
