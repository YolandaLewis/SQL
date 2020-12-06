--Yolanda Lewis Homework 2

--Question 1. Add these new ShipDate and ArriveDate columns to the shipments table you created for Hw1

ALTER TABLE SHIPMENTS 
ADD (
    ShipDate DATE,
    ArriveDate DATE
    );
commit;

UPDATE SHIPMENTS s
SET s.ShipDate = TO_DATE('01/05/2018', 'MM/DD/YYYY'), ArriveDate = TO_DATE('01/25/2019', 'MM/DD/YYYY')
WHERE ROWNUM = 1;

UPDATE SHIPMENTS s
SET s.ShipDate = TO_DATE('02/01/2018', 'MM/DD/YYYY'), ArriveDate = TO_DATE('02/04/2018', 'MM/DD/YYYY')
WHERE s.SupplierNo = 'S1' AND s.PartNo = 'P1' AND s.ProjectNo = 'J4';

UPDATE SHIPMENTS s
SET s.ShipDate = TO_DATE('12/15/2017', 'MM/DD/YYYY'), ArriveDate = TO_DATE('01/08/2018', 'MM/DD/YYYY')
WHERE s.SupplierNo = 'S1' AND s.PartNo = 'P3' AND s.ProjectNo = 'J1';

UPDATE SHIPMENTS s
SET s.ShipDate = TO_DATE('11/02/2017', 'MM/DD/YYYY'), ArriveDate = TO_DATE('11/18/2017', 'MM/DD/YYYY')
WHERE s.SupplierNo = 'S1' AND s.PartNo = 'P3' AND s.ProjectNo = 'J2';

UPDATE SHIPMENTS s
SET s.ShipDate = TO_DATE('08/05/2017', 'MM/DD/YYYY'), ArriveDate = TO_DATE('09/01/2017', 'MM/DD/YYYY')
WHERE s.SupplierNo = 'S1' AND s.PartNo = 'P3' AND s.ProjectNo = 'J3';

UPDATE SHIPMENTS s
SET s.ShipDate = TO_DATE('08/05/2017', 'MM/DD/YYYY'), ArriveDate = TO_DATE('08/09/2017', 'MM/DD/YYYY')
WHERE s.SupplierNo = 'S2' AND s.PartNo = 'P3' AND s.ProjectNo = 'J4';

UPDATE SHIPMENTS s
SET s.ShipDate = TO_DATE('07/03/2017', 'MM/DD/YYYY'), ArriveDate = TO_DATE('07/29/2017', 'MM/DD/YYYY')
WHERE s.SupplierNo = 'S2' AND s.PartNo = 'P3' AND s.ProjectNo = 'J5';

UPDATE SHIPMENTS s
SET s.ShipDate = TO_DATE('09/03/2017', 'MM/DD/YYYY'), ArriveDate = TO_DATE('09/10/2017', 'MM/DD/YYYY')
WHERE s.SupplierNo = 'S2' AND s.PartNo = 'P3' AND s.ProjectNo = 'J6';

UPDATE SHIPMENTS s
SET s.ShipDate = TO_DATE('02/05/2018', 'MM/DD/YYYY'), ArriveDate = TO_DATE('02/15/2018', 'MM/DD/YYYY')
WHERE s.SupplierNo = 'S2' AND s.PartNo = 'P3' AND s.ProjectNo = 'J7';

UPDATE SHIPMENTS s
SET s.ShipDate = TO_DATE('01/06/2018', 'MM/DD/YYYY'), ArriveDate = TO_DATE('01/14/2018', 'MM/DD/YYYY')
WHERE s.SupplierNo = 'S3' AND s.PartNo = 'P5' AND s.ProjectNo = 'J6';

UPDATE SHIPMENTS s
SET s.ShipDate = TO_DATE('03/05/2018', 'MM/DD/YYYY'), ArriveDate = TO_DATE('03/15/2018', 'MM/DD/YYYY')
WHERE s.SupplierNo = 'S3' AND s.PartNo = 'P3' AND s.ProjectNo = 'J2';

UPDATE SHIPMENTS s
SET s.ShipDate = TO_DATE('02/27/2018', 'MM/DD/YYYY'), ArriveDate = TO_DATE('03/06/2018', 'MM/DD/YYYY')
WHERE s.SupplierNo = 'S3' AND s.PartNo = 'P4' AND s.ProjectNo = 'J1';

UPDATE SHIPMENTS s
SET s.ShipDate = TO_DATE('06/15/2017', 'MM/DD/YYYY'), ArriveDate = TO_DATE('06/27/2017', 'MM/DD/YYYY')
WHERE s.SupplierNo = 'S3' AND s.PartNo = 'P6' AND s.ProjectNo = 'J2';

UPDATE SHIPMENTS s
SET s.ShipDate = TO_DATE('06/17/2017', 'MM/DD/YYYY'), ArriveDate = TO_DATE('06/30/2017', 'MM/DD/YYYY')
WHERE s.SupplierNo = 'S4' AND s.PartNo = 'P6' AND s.ProjectNo = 'J3';

UPDATE SHIPMENTS s
SET s.ShipDate = TO_DATE('05/02/2017', 'MM/DD/YYYY'), ArriveDate = TO_DATE('06/02/2017', 'MM/DD/YYYY')
WHERE s.SupplierNo = 'S4' AND s.PartNo = 'P2' AND s.ProjectNo = 'J6';

UPDATE SHIPMENTS s
SET s.ShipDate = TO_DATE('05/05/2017', 'MM/DD/YYYY'), ArriveDate = TO_DATE('05/10/2017', 'MM/DD/YYYY')
WHERE s.SupplierNo = 'S4' AND s.PartNo = 'P5' AND s.ProjectNo = 'J5';

UPDATE SHIPMENTS s
SET s.ShipDate = TO_DATE('09/15/2017', 'MM/DD/YYYY'), ArriveDate = TO_DATE('10/01/2017', 'MM/DD/YYYY')
WHERE s.SupplierNo = 'S4' AND s.PartNo = 'P5' AND s.ProjectNo = 'J2';

UPDATE SHIPMENTS s
SET s.ShipDate = TO_DATE('10/02/2017', 'MM/DD/YYYY'), ArriveDate = TO_DATE('10/23/2017', 'MM/DD/YYYY')
WHERE s.SupplierNo = 'S5' AND s.PartNo = 'P7' AND s.ProjectNo = 'J4';

UPDATE SHIPMENTS s
SET s.ShipDate = TO_DATE('11/05/2017', 'MM/DD/YYYY'), ArriveDate = TO_DATE('11/17/2017', 'MM/DD/YYYY')
WHERE s.SupplierNo = 'S5' AND s.PartNo = 'P1' AND s.ProjectNo = 'J5';

UPDATE SHIPMENTS s
SET s.ShipDate = TO_DATE('12/12/2017', 'MM/DD/YYYY'), ArriveDate = TO_DATE('01/04/2018', 'MM/DD/YYYY')
WHERE s.SupplierNo = 'S5' AND s.PartNo = 'P3' AND s.ProjectNo = 'J7';

UPDATE SHIPMENTS s
SET s.ShipDate = TO_DATE('12/22/2017', 'MM/DD/YYYY'), ArriveDate = TO_DATE('01/16/2018', 'MM/DD/YYYY')
WHERE s.SupplierNo = 'S5' AND s.PartNo = 'P4' AND s.ProjectNo = 'J4';

UPDATE SHIPMENTS s
SET s.ShipDate = TO_DATE('05/07/2018', 'MM/DD/YYYY'), ArriveDate = TO_DATE('06/01/2018', 'MM/DD/YYYY')
WHERE s.SupplierNo = 'S5' AND s.PartNo = 'P5' AND s.ProjectNo = 'J4';

UPDATE SHIPMENTS s
SET s.ShipDate = TO_DATE('04/23/2018', 'MM/DD/YYYY'), ArriveDate = TO_DATE('05/02/2018', 'MM/DD/YYYY')
WHERE s.SupplierNo = 'S5' AND s.PartNo = 'P6' AND s.ProjectNo = 'J4';

UPDATE SHIPMENTS s
SET s.ShipDate = TO_DATE('04/20/2018', 'MM/DD/YYYY'), ArriveDate = TO_DATE('05/02/2018', 'MM/DD/YYYY')
WHERE s.SupplierNo = 'S5' AND s.PartNo = 'P2' AND s.ProjectNo = 'J4';
commit;





--Question 2. With a single query, display the average number of days that each part spent in transit. Round the answers
    -- a whole day.

Select PartNo,(Round(AVG(ArriveDate - ShipDate))) As Average_Days_In_Transit 
FROM SHIPMENTS
WHERE PartNo = ANY('P1','P2','P3','P4','P5','P6','P7') 
GROUP BY PartNo
ORDER BY PartNo;   


Select PartNo,(Round(ArriveDate - ShipDate)) As Average_Days_In_Transit 
FROM SHIPMENTS 
GROUP BY PartNo, (Round(ArriveDate - ShipDate))
ORDER BY PartNo;




--Question3. With a single query, for each project, display the number of parts delivered in 2017.

Select DISTINCT ProjectNo, SUM(QUANTITY)AS Number_Of_Parts_2017
FROM SHIPMENTS
WHERE ArriveDate BETWEEN '01-JAN-17' AND '31-DEC-2017' OR ShipDate BETWEEN '01-JAN-17' AND '31-DEC-2017'
GROUP BY ProjectNo
ORDER BY ProjectNo;
