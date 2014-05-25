<?php
/**
 * Created by PhpStorm.
 * User: guweigang
 * Date: 14-5-25
 * Time: 13:45
 */

namespace Instcar\Admin\Plugins;

class jqGridOP
{
    protected $filters = array();

    protected $sidx;
    protected $sord;

    protected $page = 1;
    protected $limit = 10;

    protected $searchField = "";
    protected $searchOper = "";
    protected $searchString = "";

    protected $sql = "";

    public function __construct(array $params)
    {
        $default = array(
            'sidx'         => 'id',
            'sord'         => 'ASC',
            'filters'      => "{}",
            'searchField'  => "",
            'searchString' => "",
            'searchOper'   => "",
            'page'         => 1,
            'rows'         => 10,
        );

        foreach ($default as $key => $val) {
            if (empty($params[$key])) {
                $params[$key] = $val;
            }
        }

        $this->filters = json_decode($params['filters'], true);
        $this->sidx    = $params['sidx'];
        $this->sord    = $params['sord'];

        $this->page    = max(1, intval($params['page']));
        $this->limit   = max(10, intval($params['rows']));

        $this->searchField  = $params['searchField'];
        $this->searchOper   = $params['searchOper'];
        $this->searchString = $params['searchString'];

        $this->parseFilter();
    }

    private function parseRules($groupOp, array $rules)
    {
        $condition = "";

        foreach ($rules as $rule) {

            $oper = $rule['op'];
            $condition .= empty($condition) ? "" : " {$groupOp} ";

            switch ($oper) {
                case "eq":
                    $condition .= $rule['field'];
                    $condition .= " = ";
                    $condition .= " '" . $rule['data'] . "'";
                    break;
                case "ne":
                    $condition .= $rule['field'];
                    $condition .= " != ";
                    $condition .= " '" . $rule['data'] . "'";
                    break;
                case "bw":
                    $condition .= $rule['field'];
                    $condition .= " LIKE ";
                    $condition .= " '" . $rule['data'] . "%'";
                    break;
                case "bn":
                    $condition .= $rule['field'];
                    $condition .= " NOT LIKE ";
                    $condition .= " '" . $rule['data'] . "%'";
                    break;
                case "ew":
                    $condition .= $rule['field'];
                    $condition .= " LIKE ";
                    $condition .= " '%" . $rule['data'] . "'";
                    break;
                case "en":
                    $condition .= $rule['field'];
                    $condition .= " NOT LIKE ";
                    $condition .= " '%" . $rule['data'] . "'";
                    break;
                case "cn":
                    $condition .= $rule['field'];
                    $condition .= " LIKE ";
                    $condition .= " '%" . $rule['data'] . "%'";
                    break;
                case "nc":
                    $condition .= $rule['field'];
                    $condition .= " NOT LIKE ";
                    $condition .= " '%" . $rule['data'] . "%'";
                    break;
                case "nu":
                    $condition .= $rule['field'];
                    $condition .= " IS NULL ";
                    break;
                case "nn":
                    $condition .= $rule['field'];
                    $condition .= " IS NOT NULL ";
                    break;
                case "in":
                    $condition .= $rule['field'];
                    $condition .= " IN ";
                    $data = explode(",", $rule['data']);
                    $data = array_map("trim", $data);
                    $newData = "'" . join("','", $data) . "'";
                    $condition .= " (" . $newData . ")";
                    break;
                case "ni":
                    $condition .= $rule['field'];
                    $condition .= " NOT IN ";
                    $data = explode(",", $rule['data']);
                    $data = array_map("trim", $data);
                    $newData = "'" . join("','", $data) . "'";
                    $condition .= " (" . $newData . ")";
                    break;
                case "lt":
                    $condition .= $rule['field'];
                    $condition .= " < ";
                    $condition .= " '" . $rule['data'] . "'";
                    break;
                case "le":
                    $condition .= $rule['field'];
                    $condition .= " <= ";
                    $condition .= " '" . $rule['data'] . "'";
                    break;
                case "gt":
                    $condition .= $rule['field'];
                    $condition .= " > ";
                    $condition .= " '" . $rule['data'] . "'";
                    break;
                case "ge":
                    $condition .= $rule['field'];
                    $condition .= " >= ";
                    $condition .= " '" . $rule['data'] . "'";
                    break;
            }
        }
        return $condition;
    }

    private function parseFilter()
    {
        if(empty($this->filters)) {
            return null;
        }
        $groupOp = $this->filters['groupOp'];
        $this->sql .= $this->parseRules($groupOp, $this->filters['rules']);
    }

    public function toSql()
    {
        $this->sql .= " ORDER BY ".$this->sidx . " " . $this->sord;
        $from = ($this->page - 1) * $this->limit;
        $to   = $this->page * $this->limit;
        $this->sql .= " LIMIT {$from}, {$to}";
        return $this->sql;
    }
} 