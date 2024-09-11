<?php

namespace App\Services;

use Illuminate\Support\Facades\Log;
use League\Csv\Reader as CsvReader;
use Maatwebsite\Excel\Facades\Excel;

class FileProcessorService
{
    public function processFile($file)
    {
        try {
            $extension = $file->getClientOriginalExtension();

            switch ($extension) {
                case 'csv':
                    return $this->processCSV($file);
                case 'xlsx':
                case 'xls':
                    return $this->processExcel($file);
                default:
                    throw new \Exception('Unsupported file format');
            }
        } catch (\Exception $e) {
            Log::error('Error processing file: ' . $e->getMessage());
            throw $e;
        }
    }

    private function processCSV($file)
    {
        try {
            $csv = CsvReader::createFromPath($file->getPathname(), 'r');
            $csv->setHeaderOffset(0);
            $records = $csv->getRecords();

            return $this->validateAndExtractData(iterator_to_array($records));
        } catch (\Exception $e) {
            throw new \Exception('Error processing CSV file: ' . $e->getMessage());
        }
    }

    private function processExcel($file)
    {
        try {
            $data = Excel::toArray(null, $file);
            if (empty($data) || empty($data[0])) {
                throw new \Exception('Empty Excel file');
            }

            $headers = array_shift($data[0]); // Obtén los encabezados
            $records = array_map(function($row) use ($headers) {
                return array_combine($headers, $row);
            }, $data[0]);

            return $this->validateAndExtractData($records);
        } catch (\Exception $e) {
            throw new \Exception('Error processing Excel file: ' . $e->getMessage());
        }
    }

    private function validateAndExtractData($data)
    {
        $requiredColumns = ['firstname', 'lastname', 'department', 'has_access'];
        $output = [];

        foreach ($data as $row) {
            foreach ($requiredColumns as $column) {
                if (!isset($row[$column])) {
                    throw new \Exception("Missing required column: $column");
                }
            }

            $output[] = [
                'name' => $row['firstname'],
                'lastname' => $row['lastname'],
                'department' => $row['department'],
                'has_access' => $row['has_access'],
            ];
        }

        return $output;
    }
}